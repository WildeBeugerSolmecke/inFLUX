import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';
import 'package:meta/meta.dart';

class YoutubeChannelAndVideos{
  YoutubeChannelInfo channelInfo;
  List<YoutubeVideoInfo> videos;

  YoutubeChannelAndVideos({@required this.channelInfo, @required this.videos});
}