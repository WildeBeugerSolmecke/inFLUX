import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:meta/meta.dart';

class YoutubeChannelWithVideos {
  YoutubeChannelInfo channel;
  List<YoutubeVideoInfo> videos;

  YoutubeChannelWithVideos({@required this.channel, @required this.videos});
}
