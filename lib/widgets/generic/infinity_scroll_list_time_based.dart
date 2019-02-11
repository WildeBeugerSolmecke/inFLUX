import 'package:flutter/material.dart';
import 'package:influx/widgets/generic/tap_to_reload.dart';

typedef DataSupplierTimeBased<T> = Future<List<T>> Function({@required DateTime olderThan, @required int size});
typedef Compare<T> = int Function(T first, T second);
typedef GetDateTime<T> = DateTime Function(T object);
typedef RenderItem<T> = Widget Function(T object);

/// This widget displays a list of the provided data. If you scroll all the
/// way down, it request additional data from the provided data-provider,
/// based on the date of the currently oldest item. It also shows an error
/// message if the request fails.
// ignore: must_be_immutable
class InfinityScrollListTimeBased<T> extends StatefulWidget {
  /// Should return a list of items of type T which are older than the passed
  /// DateTime [olderThan] and have the specified [size].
  final DataSupplierTimeBased<T> dataSupplierTimeBased;
  /// Returns the DateTime of an item
  final GetDateTime<T> getDateTime;
  /// The number of items loaded if reached the bottom of the list
  final int batchSize;
  /// Determines how an item of type T is rendered in the list
  final RenderItem<T> renderItem;
  /// Comparator which determines the order in which the items are displayed
  /// by default the items are ordered chronologically with the newest at the top
  Compare<T> compare;

  InfinityScrollListTimeBased({
    Key key,
    @required this.dataSupplierTimeBased,
    @required this.renderItem,
    @required this.getDateTime,
    Compare<T> compare,
    this.batchSize = 20,
  })  : assert(dataSupplierTimeBased != null),
        assert(getDateTime != null),
        assert(renderItem != null),
        super(key: key){
    this.compare = compare ?? (a,b) => getDateTime(a).isAfter(getDateTime(b)) ? -1 : 1;
  }

  @override
  State<StatefulWidget> createState() => InfinityScrollListTimeBasedState<T>();
}

class InfinityScrollListTimeBasedState<T> extends State<InfinityScrollListTimeBased<T>> {

  // state
  DateTime _loadItemsOlderThan = DateTime.now();
  List<T> _data = List();

  final _scrollController = ScrollController();

  Future<List<T>> _loadData(DateTime olderThan) async {
    var data = await this.widget.dataSupplierTimeBased(olderThan: olderThan.subtract(Duration(milliseconds: 1)), size: this.widget.batchSize);
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
