import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/page_info.dart';

part 'channel_info_response.g.dart';

abstract class ChannelInfoResponse implements Built<ChannelInfoResponse, ChannelInfoResponseBuilder>{

  static Serializer<ChannelInfoResponse> get serializer => _$channelInfoResponseSerializer;

  String get kind;
  String get etag;
  PageInfo get pageInfo;
  BuiltList<ChannelItem> get items;

  ChannelInfoResponse._();
  factory ChannelInfoResponse([updates(ChannelInfoResponseBuilder b)]) =_$ChannelInfoResponse;
}