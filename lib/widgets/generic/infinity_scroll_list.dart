import 'package:flutter/material.dart';
import 'package:influx/widgets/generic/tap_to_reload.dart';

typedef DataSupplierOffsetBased<T> = Future<List<T>> Function(
    {@required int offset, @required int size});
typedef DataSupplierTimeBased<T> = Future<List<T>> Function(
    {@required DateTime before, @required int size});
typedef Compare<T> = int Function(T first, T second);
typedef GetDateTime<T> = DateTime Function(T object);
typedef RenderItem<T> = Widget Function(T object);

class InfinityScrollListTimeBased<T> extends StatefulWidget {
  final DataSupplierTimeBased<T> dataSupplierTimeBased;
  final Compare<T> compare;
  final GetDateTime<T> getDateTime;
  final int batchSize;
  final RenderItem<T> renderItem;

  // do not change order
  static final Compare defaultComparator = (a, b) => -1;

  InfinityScrollListTimeBased({
    Key key,
    @required this.dataSupplierTimeBased,
    @required this.renderItem,
    @required this.getDateTime,
    Compare<T> compare,
    this.batchSize = 20,
  })  : this.compare = compare ?? defaultComparator,
        assert(dataSupplierTimeBased != null),
        assert(getDateTime != null),
        assert(renderItem != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => InfinityScrollListTimeBasedState<T>();
}

class InfinityScrollListTimeBasedState<T> extends State<InfinityScrollListTimeBased<T>> {

  // state
  DateTime _loadItemsOlderThan = DateTime.now();
  List<T> _data = List();

  final _scrollController = ScrollController();

  Future<List<T>> _loadData(DateTime olderThan) async {
    var data = await this.widget.dataSupplierTimeBased(before: olderThan.subtract(Duration(milliseconds: 1)), size: this.widget.batchSize);
    this._data.addAll(data);
    this._data.sort((a,b) => this.widget.compare(a,b));
    return this._data;
  }

  Future<Null> _onRefresh() async{
    this.setState((){
      this._data.clear();
      this._loadItemsOlderThan = DateTime.now();
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        this.setState(() => _loadItemsOlderThan = (this._data.length>0) ? this.widget.getDateTime(this._data.last) : DateTime.now());
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
        future: _loadData(this._loadItemsOlderThan),
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
          if(snapshot.hasError){
            return TapToReload(
              onTap: () => this.setState((){}),
            );
          }
          else return Center(child: CircularProgressIndicator());
        });
  }
}
