import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_mention.g.dart';

abstract class UserMention implements Built<UserMention, UserMentionBuilder>{

  static Serializer<UserMention> get serializer => _$userMentionSerializer;

  int get id;
  @BuiltValueField(wireName: "id_str")
  String get idStr;
  BuiltList<int> get indices;
  String get name;
  @BuiltValueField(wireName: "screen_name")
  String get screenName;

  UserMention._();
  factory UserMention([updates(UserMentionBuilder b)]) = _$UserMention;
}