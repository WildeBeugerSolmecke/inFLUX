import 'package:flutter/material.dart';
import 'package:influx/utility/youtube/datetime_converter.dart';
import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';

class YoutubeVideoListItem extends StatelessWidget {
  final YoutubeVideoInfo videoInfo;
  final YoutubeChannelInfo channelInfo;

  YoutubeVideoListItem(
      {Key key, @required this.videoInfo, @required this.channelInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Material(
          color: Color(0XFFFFFFFF),
          elevation: 2.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 12.0, bottom: 2.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                      this.videoInfo.thumbnailUrls[ThumbnailResolution.HIGH],
                      fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                        child: Image.network(
                            this
                                .channelInfo
                                .thumbnailUrls[ThumbnailResolution.MEDIUM],
                            width: 90,
                            height: 90)),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 8.0),
                          Text(
                            this.videoInfo.title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            this.channelInfo.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0XFF646464),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${DateTimeConverter.getDurationAsText(videoInfo.publishedAt)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0XFFBBBBBB),
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
