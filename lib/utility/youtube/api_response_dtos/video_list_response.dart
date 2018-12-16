import 'package:built_collection/built_collection.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/page_info.dart';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'video_list_response.g.dart';

abstract class VideoListResponse implements Built<VideoListResponse, VideoListResponseBuilder>{

  static Serializer<VideoListResponse> get serializer => _$videoListResponseSerializer;

  String get kind;
  String get etag;
  String get nextPageToken;
  String get regionCode;
  PageInfo get pageInfo;
  BuiltList<VideoItem> get items;

  VideoListResponse._();
  factory VideoListResponse([updates(VideoListResponseBuilder b)]) =_$VideoListResponse;

}