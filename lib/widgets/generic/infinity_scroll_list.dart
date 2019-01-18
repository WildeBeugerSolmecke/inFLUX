import 'package:flutter/material.dart';

typedef DataSupplierOffsetBased<T> = Future<List<T>> Function(
    {@required int offset, @required int size});
typedef DataSupplierTimeBased<T> = Future<List<T>> Function(
    {@required DateTime before, @required int size});
typedef Compare<T> = int Function(T first, T second);
typedef GetDateTime<T> = DateTime Function(T object);
typedef RenderItem<T> = Widget Function(T object);

enum WidgetState { INITIAL_STATE, ITEMS_LOADED, LOADING_MORE, HAS_ERROR }
enum LoadSetting { OFFSET_BASED, TIME_BASED }

class InfinityScrollList<T> extends StatefulWidget {
  final DataSupplierOffsetBased<T> dataSupplierOffsetBased;
  final DataSupplierTimeBased<T> dataSupplierTimeBased;
  final Compare<T> compare;
  final GetDateTime<T> getDateTime;
  final int batchSize;
  final RenderItem<T> renderItem;
  final LoadSetting loadSetting;

  // do not change order
  static final Compare defaultComparator = (a, b) => -1;

  InfinityScrollList.timeBased({
    Key key,
    @required this.dataSupplierTimeBased,
    @required this.renderItem,
    @required this.getDateTime,
    Compare<T> compare,
    this.batchSize = 20,
  })  : loadSetting = LoadSetting.TIME_BASED,
        this.compare = compare ?? defaultComparator,
        this.dataSupplierOffsetBased = null,
        assert(dataSupplierTimeBased != null),
        assert(getDateTime != null),
        assert(renderItem != null),
        super(key: key);

  InfinityScrollList.offsetBased(
      {Key key,
      @required this.dataSupplierOffsetBased,
      @required this.renderItem,
      Compare<T> compare,
      this.batchSize = 20})
      : loadSetting = LoadSetting.OFFSET_BASED,
        this.getDateTime = null,
        this.dataSupplierTimeBased = null,
        this.compare = compare ?? defaultComparator,
        assert(dataSupplierOffsetBased != null),
        assert(renderItem != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    switch (loadSetting) {
      case LoadSetting.TIME_BASED:
        return InfinityScrollListTimeBasedState<T>();
      case  LoadSetting.OFFSET_BASED:
        return InfinityScrollListOffsetBasedState<T>();
      default: throw Exception("LoadSetting not supported");
    }
  }
}

abstract class InfinityScrollListState<T> extends State<InfinityScrollList<T>> {

  final _scrollController = ScrollController();
  // state
  WidgetState _state = WidgetState.INITIAL_STATE;
  List<T> _data = List();

  InfinityScrollListState();

  Future<void> _loadMoreData();
  Future<void> _loadInitialData();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_state == WidgetState.INITIAL_STATE) _loadInitialData();

    return _state == WidgetState.INITIAL_STATE
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => _loadInitialData(),
            child: ListView.builder(
              controller: this._scrollController,
              itemCount: _data.length + 1,
              itemBuilder: (context, position) {
                if (position < _data.length)
                  return this.widget.renderItem(_data[position]);
                else if (position >= _data.length &&
                    _state == WidgetState.LOADING_MORE) {
                  return Center(
                    child: Opacity(
                      opacity: _state == WidgetState.LOADING_MORE ? 1.0 : 0.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          );
  }
}

class InfinityScrollListTimeBasedState<T> extends InfinityScrollListState<T> {

  InfinityScrollListTimeBasedState(): super();

  @override
  Future<void> _loadMoreData() async {
    setState(() => _state = WidgetState.LOADING_MORE);

    List<T> additionalData = List();

    final lastVideoPublishedAt = this.widget.getDateTime(_data.last);
    // decrease by 1 milliseconds so we don't render the last video twice
    final beforeLastVideoPublished =
        lastVideoPublishedAt.subtract(Duration(milliseconds: 1));
    try {
      additionalData = await this.widget.dataSupplierTimeBased(
          before: beforeLastVideoPublished, size: this.widget.batchSize);
    } catch (e) {
      this.setState(() => _state = WidgetState.HAS_ERROR);
      return;
    }
    // add them all
    _data.addAll(additionalData);
    // sort data list if necessary
    _data.sort((a, b) => this.widget.compare(a, b));
    // re-render list
    this.setState(() => _state = WidgetState.ITEMS_LOADED);
  }

  @override
  Future<void> _loadInitialData() async {
    setState(() => _state = WidgetState.INITIAL_STATE);

    List<T> data = List();
    try {
      data = await this.widget
          .dataSupplierTimeBased(before: DateTime.now(), size: this.widget.batchSize);
    } catch (e) {
      this.setState(() => _state = WidgetState.HAS_ERROR);
      return;
    }
    this._data = data;
    // sort data
    data.sort((a, b) => this.widget.compare(a, b));
    // re-render list
    this.setState(() => _state = WidgetState.ITEMS_LOADED);
  }
}

class InfinityScrollListOffsetBasedState<T> extends InfinityScrollListState<T> {
  InfinityScrollListOffsetBasedState() : super();

  @override
  Future<void> _loadInitialData() async {
    setState(() => _state = WidgetState.INITIAL_STATE);

    List<T> data = List();
    try {
      data = await this.widget.dataSupplierOffsetBased(offset: 0, size: this.widget.batchSize);
    } catch (e) {
      this.setState(() => _state = WidgetState.HAS_ERROR);
      return;
    }
    this._data = data;
    // sort data
    data.sort((a, b) => this.widget.compare(a, b));
    // re-render list
    this.setState(() => _state = WidgetState.ITEMS_LOADED);
  }

  @override
  Future<void> _loadMoreData() async {
    setState(() => _state = WidgetState.LOADING_MORE);
    List<T> data = List();
    try {
      data = await this.widget.dataSupplierOffsetBased(offset: data.length, size: this.widget.batchSize);
    } catch (e) {
      this.setState(() => _state = WidgetState.HAS_ERROR);
      return;
    }
    this._data.addAll(data);
    // sort data
    data.sort((a, b) => this.widget.compare(a, b));
    // re-render list
    this.setState(() => _state = WidgetState.ITEMS_LOADED);
  }
}
