import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_snippet.dart';

part 'channel_item.g.dart';

abstract class ChannelItem implements Built<ChannelItem, ChannelItemBuilder>{

  static Serializer<ChannelItem> get serializer => _$channelItemSerializer;

  String get kind;
  String get etag;
  String get id;
  ChannelSnippet get snippet;

  ChannelItem._();
  factory ChannelItem([updates(ChannelItemBuilder b)]) =_$ChannelItem;

}