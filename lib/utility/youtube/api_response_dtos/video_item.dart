import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/youtube/api_response_dtos/id.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_snippet.dart';

part 'video_item.g.dart';

abstract class VideoItem implements Built<VideoItem, VideoItemBuilder>{

  static Serializer<VideoItem> get serializer => _$videoItemSerializer;

  String get kind;
  String get etag;
  Id get id;
  VideoSnippet get snippet;

  VideoItem._();
  factory VideoItem([updates(VideoItemBuilder b)]) =_$VideoItem;

}