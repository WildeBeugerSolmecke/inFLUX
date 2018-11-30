import 'package:flutter/material.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';

class YoutubeVideoListItem extends StatelessWidget{


  final YoutubeVideoInfo videoInfo;
  final YoutubeChannelInfo channelInfo;

  YoutubeVideoListItem({Key key, @required this.videoInfo, @required this.channelInfo}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
          Image.network(videoInfo.thumbnailUrls[ThumbnailSize.MEDIUM], fit: BoxFit.fitWidth),
          Text(this.videoInfo.title, style: new TextStyle(color: Colors.white, fontSize: 18))
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}