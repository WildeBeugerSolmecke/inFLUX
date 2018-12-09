import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_info.g.dart';

abstract class PageInfo implements Built<PageInfo, PageInfoBuilder>{

  static Serializer<PageInfo> get serializer => _$pageInfoSerializer;

  int get totalResults;
  int get resultsPerPage;

  PageInfo._();
  factory PageInfo([updates(PageInfoBuilder b)]) =_$PageInfo;
}