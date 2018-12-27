import 'package:flutter/material.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/youtube_page/youtube_video_list_item.dart';

class YoutubePage extends StatefulWidget {
  final YoutubeApiAdapter apiAdapter;

  YoutubePage({this.apiAdapter, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _YoutubePageState(youtubeApiAdapter: this.apiAdapter);
}

class _YoutubePageState extends State<YoutubePage> {
  final YoutubeApiAdapter youtubeApiAdapter;

  // state
  YoutubeChannelInfo _chanelInfo;
  List<YoutubeVideoInfo> _videos = new List();
  var _isLoadingAdditionalData = false;
  var _isLoadingInitialData = true;

  final _scrollController = ScrollController();
  static const _videoBatchSize = 20;

  _YoutubePageState({YoutubeApiAdapter youtubeApiAdapter})
      : youtubeApiAdapter = youtubeApiAdapter ?? YoutubeApiAdapter();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        this._loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingInitialData) {
      youtubeApiAdapter
          .getYoutubeChannelAndVideos(
              channelId: InFluxConfig.youtubeChannelId,
              apiKey: InFluxConfig.youtubeApiKey,
              maxResults: _videoBatchSize)
          .then((channelAndVideos) {
        this._chanelInfo = channelAndVideos.channel;
        this._videos = channelAndVideos.videos;
        this._isLoadingInitialData = false;
        setState(() {});
      });
    }

    return Material(
        color: Colors.black26,
        child: _isLoadingInitialData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  if (index < _videos.length) {
                    return YoutubeVideoListItem(
                        videoInfo: _videos[index], channelInfo: _chanelInfo);
                  }
                  return Center(
                    child: Opacity(
                      opacity: _isLoadingAdditionalData ? 1.0 : 0.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                itemCount: _videos.length + 1,
                controller: _scrollController,
              ));
  }

  void _loadMore() async {
    setState(() => _isLoadingAdditionalData = true);
    final lastVideoPublishedAt = _videos.last.publishedAt;
    // decrease by 1 milliseconds so we don't render the last video twice
    final afterLastVideoPublished =
        lastVideoPublishedAt.subtract(Duration(milliseconds: 1));

    var olderVideos = await youtubeApiAdapter.getVideos(
        channelId: InFluxConfig.youtubeChannelId,
        apiKey: InFluxConfig.youtubeApiKey,
        maxResults: _videoBatchSize,
        publishedBefore: afterLastVideoPublished);
    // add them all
    _videos.addAll(olderVideos);
    // sort by date
    _videos.sort((a, b) => a.publishedAt.isAfter(b.publishedAt) ? -1 : 1);
    // re-render list
    this.setState(() => _isLoadingAdditionalData = false);
  }
}
