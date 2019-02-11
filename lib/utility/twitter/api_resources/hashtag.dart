import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hashtag.g.dart';

abstract class Hashtag implements Built<Hashtag, HashtagBuilder>{

  static Serializer<Hashtag> get serializer => _$hashtagSerializer;

  BuiltList<int> get indices;
  String get text;

  Hashtag._();
  factory Hashtag([updates(HashtagBuilder b)]) = _$Hashtag;

}