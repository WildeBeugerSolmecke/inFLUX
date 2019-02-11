import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'turl.g.dart';

abstract class TUrl implements Built<TUrl, TUrlBuilder>{
  static Serializer<TUrl> get serializer => _$tUrlSerializer;

  @BuiltValueField(wireName: "display_url")
  String get displayUrl;
  @BuiltValueField(wireName: "expanded_url")
  String get expandedUrl;
  BuiltList<int> get indices;
  String get url;

  TUrl._();
  factory TUrl([updates(TUrlBuilder b)]) = _$TUrl;
}