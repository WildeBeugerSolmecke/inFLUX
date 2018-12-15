import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:influx/utility/youtube/youtube_api_adapter.dart';
import 'package:influx/utility/youtube/model/youtube_channel_with_videos.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/youtube_page/youtube_video_list_item.dart';

class YoutubePage extends StatelessWidget {
  final String title;

  YoutubePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        backgroundColor: Colors.black26,
        body: FutureBuilder<YoutubeChannelWithVideos>(
          future: YoutubeApiAdapter().getYoutubeChannelAndVideos(
              httpClient: Client(),
              channelId: InFluxConfig.youtubeChannelId,
              apiKey: InFluxConfig.youtubeApiKey),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var channelInfo = snapshot.data.channel;
              var videos = snapshot.data.videos;
              return ListView.builder(
                  itemBuilder: (context, index) => YoutubeVideoListItem(
                      videoInfo: videos[index], channelInfo: channelInfo),
                  itemCount: videos.length);
            } else if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            // By default, show a loading spinner
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
