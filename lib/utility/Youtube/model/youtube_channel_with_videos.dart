import 'package:influx/utility/Youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/Youtube/model/youtube_video_info.dart';
import 'package:meta/meta.dart';

class YoutubeChannelWithVideos{
  YoutubeChannelInfo channel;
  List<YoutubeVideoInfo> videos;

  YoutubeChannelWithVideos({@required this.channel, @required this.videos});
}