import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/twitter/api_resources/entities.dart';
import 'package:influx/utility/twitter/api_resources/user.dart';

part 'tweet.g.dart';

abstract class Tweet implements Built<Tweet, TweetBuilder>{

  static Serializer<Tweet> get serializer => _$tweetSerializer;

  @BuiltValueField(wireName: "created_at")
  String get createdAt;
  int get id;
  @BuiltValueField(wireName: "id_str")
  String get idStr;
  @BuiltValueField(wireName: "full_text")
  String get fullText;
  bool get truncated;
  @nullable
  @BuiltValueField(wireName: "display_Text_Range")
  List<int> get displayTextRange;
  Entities get entities;
  @nullable
  @BuiltValueField(wireName: "in_reply_to_status_id")
  int get inReplyToStatusId;
  @nullable
  @BuiltValueField(wireName: "in_reply_to_user_id")
  int get inReplyToUserId;
  @nullable
  @BuiltValueField(wireName: "in_reply_to_screen_name")
  String get inReplyToScreenName;
  User get user;
  @nullable
  @BuiltValueField(wireName: "quoted_status_id")
  int get quotedStatusId;
  @nullable
  @BuiltValueField(wireName: "reply_count")
  int get replyCount;
  @nullable
  @BuiltValueField(wireName: "retweet_count")
  int get retweetCount;
  @nullable
  @BuiltValueField(wireName: "favorite_count")
  int get favoriteCount;

  Tweet._();
  factory Tweet([updates(TweetBuilder b)]) = _$Tweet;


}