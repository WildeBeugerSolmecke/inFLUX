import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/twitter/api_resources/hashtag.dart';
import 'package:influx/utility/twitter/api_resources/media.dart';
import 'package:influx/utility/twitter/api_resources/turl.dart';
import 'package:influx/utility/twitter/api_resources/user_mention.dart';

part 'entities.g.dart';

abstract class Entities implements Built<Entities, EntitiesBuilder>{

  static Serializer<Entities> get serializer => _$entitiesSerializer;

  BuiltList<Hashtag> get hashtags;
  BuiltList<TUrl> get urls;
  @BuiltValueField(wireName: "user_mentions")
  BuiltList<UserMention> get userMentions;
  @nullable
  BuiltList<Media> get media;

  Entities._();
  factory Entities([updates(EntitiesBuilder b)]) = _$Entities;

}