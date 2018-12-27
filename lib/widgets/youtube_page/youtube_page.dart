import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';
import 'package:influx/utility/youtube/model/youtube_channel_with_videos.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/youtube_page/youtube_video_list_item.dart';

class YoutubePage extends StatefulWidget {
  final YoutubeApiAdapter apiAdapter;

  YoutubePage({this.apiAdapter, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _YoutubePageState(apiAdapter: this.apiAdapter);
}

class _YoutubePageState extends State<YoutubePage> {
  final YoutubeApiAdapter apiAdapter;

  // state
  YoutubeChannelInfo chanelInfo;
  List<YoutubeVideoInfo> videos = new List();
  var isLoading = false;
  var isInitialLoad = true;

  final scrollController = ScrollController();
  static const videoBatchSize = 20;

  _YoutubePageState({@required YoutubeApiAdapter apiAdapter})
      : apiAdapter = apiAdapter ?? YoutubeApiAdapter();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      print(scrollController.position.extentAfter);
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        this._loadMore();
      }
    });

    this.setState(() => isInitialLoad == true);

    apiAdapter.getYoutubeChannelAndVideos(
        channelId: InFluxConfig.youtubeChannelId,
        apiKey: InFluxConfig.youtubeApiKey,
        maxResults: videoBatchSize)
        .then((channelAndVideos) {
      this.setState(() {
        this.isInitialLoad = false;
        this.videos = channelAndVideos.videos;
        this.chanelInfo = channelAndVideos.channel;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black26,
        child: isInitialLoad
            ? Center(
                child: Opacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index < videos.length) {
                    return YoutubeVideoListItem(
                        videoInfo: videos[index], channelInfo: chanelInfo);
                  }
                  return Center(
                    child: Opacity(
                      opacity: isLoading ? 1.0 : 0.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                itemCount: videos.length + 1,
              ));
  }

  void _loadMore() async {
    setState(() => isLoading = true);
    DateTime lastVideoPublishedAt = videos.last.publishedAt;
    var olderVideos = await apiAdapter.getVideos(
        channelId: InFluxConfig.youtubeChannelId,
        apiKey: InFluxConfig.youtubeChannelId,
        maxResults: videoBatchSize,
        since: lastVideoPublishedAt);
    videos.addAll(olderVideos);
    // sort by date
    videos.sort((a, b) => a.publishedAt.isAfter(b.publishedAt) ? 1 : -1);
    // remove doubles
    for (int i = 0; i < videos.length - 1; i++) {
      if (videos[i] == videos[i + 1]) {
        videos.removeAt(i);
      }
    }
    // re-render list
    this.setState(() => isLoading = false);
  }
}
