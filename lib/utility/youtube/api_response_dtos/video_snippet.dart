import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:influx/utility/youtube/api_response_dtos/thumbnails.dart';

part 'video_snippet.g.dart';

abstract class VideoSnippet implements Built<VideoSnippet, VideoSnippetBuilder>{

  static Serializer<VideoSnippet> get serializer => _$videoSnippetSerializer;

  String get publishedAt;
  String get channelId;
  String get title;
  String get description;
  Thumbnails get thumbnails;
  String get channelTitle;
  String get liveBroadcastContent;

  VideoSnippet._();
  factory VideoSnippet([updates(VideoSnippetBuilder b)]) = _$VideoSnippet;
}