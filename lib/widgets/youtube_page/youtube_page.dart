import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';
import 'package:influx/widgets/generic/infinity_scroll_list_time_based.dart';
import 'package:influx/widgets/generic/tap_to_reload.dart';
import 'package:influx/widgets/youtube_page/youtube_app_bar.dart';
import 'package:influx/widgets/youtube_page/youtube_video_list_item.dart';

class YoutubePage extends StatefulWidget {
  final YoutubeApiAdapter youtubeApiAdapter;

  YoutubePage({this.youtubeApiAdapter, Key key}) : super(key: key);

  @override
  YoutubePageState createState() => new YoutubePageState();
}

class YoutubePageState extends State<YoutubePage> {
  static const _videoBatchSize = 20;
  final YoutubeApiAdapter _youtubeApiAdapter;

  YoutubePageState({YoutubeApiAdapter youtubeApiAdapter})
      : _youtubeApiAdapter = youtubeApiAdapter ?? YoutubeApiAdapter();

  @override
  Widget build(BuildContext context) {
    print("building youtube_page");
    return FutureBuilder<YoutubeChannelInfo>(
        future: _youtubeApiAdapter.getChannelInfo(
            channelId: InFluxConfig.youtubeChannelId,
            apiKey: InFluxConfig.youtubeApiKey),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var channelInfo = snapshot.data;
            return Scaffold(
                appBar: YoutubeAppBar(channelName: channelInfo.title),
                body: InfinityScrollListTimeBased<YoutubeVideoInfo>(
                    dataSupplierTimeBased: ({olderThan, size}) =>
                        _youtubeApiAdapter.getVideos(
                            channelId: InFluxConfig.youtubeChannelId,
                            apiKey: InFluxConfig.youtubeApiKey,
                            maxResults: size,
                            publishedBefore: olderThan),
                    compare: (a, b) =>
                        a.publishedAt.isAfter(b.publishedAt) ? -1 : 1,
                    getDateTime: (video) => video.publishedAt,
                    batchSize: _videoBatchSize,
                    renderItem: (video) => YoutubeVideoListItem(
                        videoInfo: video, channelInfo: channelInfo)));
          }
          if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
            return TapToReload(onTap: reload);
          }
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  void reload(){
    this.setState((){});
  }
}
