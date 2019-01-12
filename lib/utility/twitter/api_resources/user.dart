import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder>{

  static Serializer<User> get serializer => _$userSerializer;

  int get id;
  @nullable
  String get idStr;
  String get name;
  @BuiltValueField(wireName: "screen_name")
  String get screenName;
  @nullable
  String get location;
  @nullable
  String get description;
  @nullable
  String get url;
  @nullable
  bool get protected;
  @BuiltValueField(wireName: "followers_count")
  int get followersCount;
  @BuiltValueField(wireName: "friends_count")
  int get friendsCount;
  @BuiltValueField(wireName: "listed_count")
  int get listedCount;
  @BuiltValueField(wireName: "created_at")
  String get createdAt;
  @BuiltValueField(wireName: "favourites_count")
  int get favouritesCount;
  @nullable
  @BuiltValueField(wireName: "geo_enabled")
  bool get geoEnabled;
  @nullable
  bool get verified;
  @nullable
  @BuiltValueField(wireName: "statuses_count")
  int get statusesCount;
  @nullable
  String get lang;
  @nullable
  @BuiltValueField(wireName: "contributors_enabled")
  bool get contributorsEnabled;
  @nullable
  @BuiltValueField(wireName: "is_translator")
  bool get isTranslator;
  @nullable
  @BuiltValueField(wireName: "is_transportation_enabled")
  bool get isTranslationEnabled;
  @nullable
  @BuiltValueField(wireName: "profile_background_color")
  String get profileBackgroundColor;
  @nullable
  @BuiltValueField(wireName: "profile_background_image_url")
  String get profileBackgroundImageUrl;
  @nullable
  @BuiltValueField(wireName: "profile_background_image_url_https")
  String get profileBackgroundImageUrlHttps;
  @nullable
  @BuiltValueField(wireName: "profile_background_tile")
  bool get profileBackgroundTile;
  @nullable
  @BuiltValueField(wireName: "profile_image_url")
  String get profileImageUrl;
  @BuiltValueField(wireName: "profile_image_url_https")
  String get profileImageUrlHttps;
  @nullable
  @BuiltValueField(wireName: "profile_banner_url")
  String get profileBannerUrl;
  @nullable
  @BuiltValueField(wireName: "profile_link_color")
  String get profileLinkColor;
  @nullable
  @BuiltValueField(wireName: "profile_sidebar_border_color")
  String get profileSidebarBorderColor;
  @nullable
  @BuiltValueField(wireName: "profile_sidebar_fill_color")
  String get profileSidebarFillColor;
  @nullable
  @BuiltValueField(wireName: "profile_text_color")
  String get profileTextColor;
  @nullable
  @BuiltValueField(wireName: "profile_use_background_image")
  bool get profileUseBackgroundImage;
  @nullable
  @BuiltValueField(wireName: "has_extended_profile")
  bool get hasExtendedProfile;
  @nullable
  @BuiltValueField(wireName: "default_profile")
  bool get defaultProfile;
  @BuiltValueField(wireName: "default_profile_image")
  @nullable
  bool get defaultProfileImage;
  @nullable
  @BuiltValueField(wireName: "translator_type")
  String get translatorType;

  User._();
  factory User([updates(UserBuilder b)]) = _$User;
}
