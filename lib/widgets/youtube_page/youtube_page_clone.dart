import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/youtube/api_response_dtos/medium.dart';
import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';

class YoutubePageClone extends StatefulWidget {
  final YoutubeApiAdapter youtubeApiAdapter;

  YoutubePageClone({this.youtubeApiAdapter, Key key}) : super(key: key);

  @override
  YoutubePageCloneState createState() => new YoutubePageCloneState();
}

class YoutubePageCloneState extends State<YoutubePageClone> {
  final YoutubeApiAdapter youtubeApiAdapter;

  // state
  YoutubeChannelInfo _chanelInfo;
  List<YoutubeVideoInfo> _videos = new List();
  var _isLoadingAdditionalData = false;
  var _isLoadingInitialData = true;

  final _scrollController = ScrollController();
  static const _videoBatchSize = 20;

  YoutubePageCloneState({YoutubeApiAdapter youtubeApiAdapter})
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


    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "YouTube - ",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "KanzleiWBS",
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ))),
      body: Center(
        child: _isLoadingInitialData
        ? CircularProgressIndicator()
        : ListView.builder(
          controller: this._scrollController,
          itemCount: _videos.length +1,
          itemBuilder: (context, position) {
            if (position < _videos.length) {
              return GestureDetector(
                onTap: () {
                  print("tapped $position.");
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Image.network(
                              _videos[position].thumbnailUrls[ThumbnailResolution.MEDIUM],
                              fit: BoxFit.cover,)
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(child: Image.network(
                                this._chanelInfo.thumbnailUrls[ThumbnailResolution.MEDIUM],
                                width: 40, height: 40)),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    _videos[position].title,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                Text(
                                  _chanelInfo.title,
                                  style: TextStyle(color: Colors.black54),
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
              );
            }
            return Center(
              child: Opacity(
                opacity: _isLoadingAdditionalData ? 1.0 : 0.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
        ),
      ),
    );
  }
}
