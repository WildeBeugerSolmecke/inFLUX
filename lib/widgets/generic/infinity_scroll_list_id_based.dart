import 'package:flutter/material.dart';
import 'package:influx/widgets/generic/tap_to_reload.dart';

typedef DataSupplierIdBased<T> = Future<List<T>> Function(
    {@required int size, String olderThanId});
typedef IdExtractor<T> = String Function(T item);
typedef Compare<T> = int Function(T first, T second);
typedef RenderItem<T> = Widget Function(T object);

/// This widget displays a list of the provided data. If you scroll all the
/// way down, it request additional data from the provided data-provider,
/// based on the date of the currently oldest item. It also shows an error
/// message if the request fails.
// ignore: must_be_immutable
class InfinityScrollListIdBased<T> extends StatefulWidget {
  /// Should return a list of items of type T which are older than the passed
  /// DateTime [olderThan] and have the specified [size].
  final DataSupplierIdBased<T> dataSupplierIdBased;

  /// The number of items loaded if reached the bottom of the list
  final int batchSize;

  /// Determines how an item of type T is rendered in the list
  final RenderItem<T> renderItem;

  /// Comparator which determines the order in which the items are displayed
  /// by default the items are ordered chronologically with the newest at the top
  Compare<T> compare;

  /// Extracts the Id of an item of type T
  IdExtractor<T> idExtractor;

  InfinityScrollListIdBased({
    Key key,
    @required this.dataSupplierIdBased,
    @required this.renderItem,
    @required this.idExtractor,
    Compare<T> compare,
    this.batchSize = 20,
  })  : assert(dataSupplierIdBased != null),
        assert(renderItem != null),
        assert(idExtractor != null),
        super(key: key) {
    this.compare = compare ?? (a, b) => -1;
  }

  @override
  State<StatefulWidget> createState() => InfinityScrollListIdBasedState<T>();
}

class InfinityScrollListIdBasedState<T>
    extends State<InfinityScrollListIdBased<T>> {
  // state
  String _loadItemsOlderThanId;
  List<T> _data = List();

  final _scrollController = ScrollController();

  Future<List<T>> _loadData([String olderThanId]) async {
    var data = (olderThanId == null)
        ? await this.widget.dataSupplierIdBased(size: this.widget.batchSize)
        : await this.widget.dataSupplierIdBased(
            olderThanId: olderThanId, size: this.widget.batchSize);

    this._data.addAll(data);
    this._data.sort((a, b) => this.widget.compare(a, b));
    return this._data;
  }

  Future<Null> _onRefresh() async {
    this.setState(() {
      this._data.clear();
      this._loadItemsOlderThanId = null;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        this.setState(() => _loadItemsOlderThanId = (this._data.length > 0)
            ? this.widget.idExtractor(this._data.last)
            : null);
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
    return FutureBuilder(
        future: _loadData(this._loadItemsOlderThanId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: this._scrollController,
                itemCount: _data.length + 1,
                itemBuilder: (context, position) {
                  if (position < _data.length)
                    return this.widget.renderItem(_data[position]);
                  else if (position >= _data.length) {
                    return Center(
                      child: Opacity(
                        opacity:
                            snapshot.connectionState == ConnectionState.waiting
                                ? 1.0
                                : 0.0,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return TapToReload(
              onTap: () => this.setState(() {}),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
