import 'package:flutter/material.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';

class YoutubeVideoListItem extends StatelessWidget{


  final YoutubeVideoInfo videoInfo;
  YoutubeVideoListItem({Key key, @required this.videoInfo}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.videoInfo.title)
    );
  }
}