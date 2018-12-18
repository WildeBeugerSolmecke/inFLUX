import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/youtube/api_response_dtos/localized.dart';
import 'package:influx/utility/youtube/api_response_dtos/thumbnails.dart';

part 'channel_snippet.g.dart';


abstract class ChannelSnippet implements Built<ChannelSnippet, ChannelSnippetBuilder> {

  static Serializer<ChannelSnippet> get serializer => _$channelSnippetSerializer;

  String get title;
  String get description;
  String get customUrl;
  String get publishedAt;
  Thumbnails get thumbnails;
  Localized get localized;

  ChannelSnippet._();
  factory ChannelSnippet([updates(ChannelSnippetBuilder b)]) =_$ChannelSnippet;
}