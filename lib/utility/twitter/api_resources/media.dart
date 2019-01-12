import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media.g.dart';

abstract class Media implements Built<Media, MediaBuilder>{

  static Serializer<Media> get serializer => _$mediaSerializer;

  @BuiltValueField(wireName: "display_url")
  String get displayUrl;
  @BuiltValueField(wireName: "expanded_url")
  String get expandedUrl;
  int get id;
  @BuiltValueField(wireName: "id_str")
  String get idStr;
  BuiltList<int> get indices;
  @BuiltValueField(wireName: "media_url")
  String get mediaUrl;
  @BuiltValueField(wireName: "media_url_https")
  String get mediaUrlHttps;

  Media._();
  factory Media([updates(MediaBuilder b)]) = _$Media;

}