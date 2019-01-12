import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:influx/utility/twitter/api_resources/entities.dart';
import 'package:influx/utility/twitter/api_resources/hashtag.dart';
import 'package:influx/utility/twitter/api_resources/media.dart';
import 'package:influx/utility/twitter/api_resources/size.dart';
import 'package:influx/utility/twitter/api_resources/turl.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:influx/utility/twitter/api_resources/user.dart';
import 'package:influx/utility/twitter/api_resources/user_mention.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  User,
  Entities,
  Hashtag,
  Media,
  Size,
  TUrl,
  Tweet,
  UserMention
])
final Serializers serializers  =
(
    _$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
).build();