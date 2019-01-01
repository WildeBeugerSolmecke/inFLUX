import 'package:flutter/material.dart';
import 'package:influx/utility/youtube/datetime_converter.dart';
import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeVideoListItem extends StatelessWidget {
  final YoutubeVideoInfo videoInfo;
  final YoutubeChannelInfo channelInfo;

  YoutubeVideoListItem(
      {Key key, @required this.videoInfo, @required this.channelInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => launch("https://www.youtube.com/watch?v=${videoInfo.id}"),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Image.network(
                    videoInfo.thumbnailUrls[ThumbnailResolution.MEDIUM],
                    fit: BoxFit.cover,
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                        child: Image.network(
                            this
                                .channelInfo
                                .thumbnailUrls[ThumbnailResolution.MEDIUM],
                            width: 40,
                            height: 40)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              videoInfo.title,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                channelInfo.title,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w800),
                              ),
                              Expanded(
                                child: Text(
                                    DateTimeConverter.getDurationAsText(
                                        videoInfo.publishedAt),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.end),
                              ),
                            ],
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      flex: 9,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
        )
      ],
    );
  }
}
