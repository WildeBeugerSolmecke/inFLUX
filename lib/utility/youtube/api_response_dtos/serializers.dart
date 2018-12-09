library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:influx/utility/youtube/api_response_dtos/channel_info_response.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_snippet.dart';
import 'package:influx/utility/youtube/api_response_dtos/default.dart';
import 'package:influx/utility/youtube/api_response_dtos/high.dart';
import 'package:influx/utility/youtube/api_response_dtos/id.dart';
import 'package:influx/utility/youtube/api_response_dtos/localized.dart';
import 'package:influx/utility/youtube/api_response_dtos/medium.dart';
import 'package:influx/utility/youtube/api_response_dtos/page_info.dart';
import 'package:influx/utility/youtube/api_response_dtos/thumbnails.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_list_response.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_snippet.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  VideoListResponse,
  ChannelInfoResponse,
  ChannelItem,
  ChannelSnippet,
  Default,
  High,
  Id,
  Localized,
  Medium,
  PageInfo,
  Thumbnails,
  VideoItem,
  VideoSnippet
])
final Serializers serializers  =
  (
      _$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
  ).build();