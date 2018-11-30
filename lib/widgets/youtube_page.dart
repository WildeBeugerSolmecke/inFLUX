import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:influx/utility/Youtube/youtube_api_adapter.dart';
import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/youtube_video_list_item.dart';

class YoutubePage extends StatelessWidget {
  final String title;
  final YoutubeChannelInfo channelInfo;

  @override
  Widget build(BuildContext context) {
    // FlutterYoutube.playYoutubeVideoByUrl(apiKey: "AIzaSyBoht9JEZzn_-E6p3tHVsErOyL77yXko_M", videoUrl: "https://www.youtube.com/watch?v=E7jwPMxJMfo");
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        backgroundColor: Colors.black26,
        body: FutureBuilder<List<YoutubeVideoInfo>>(
          future: YoutubeApiAdapter().getVideos(apiKey: InFluxConfig.youtubeApiKey, channelId: InFluxConfig.youtubeChannelId, results: 20),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var videos = snapshot.data;
              return ListView.builder(
                  itemBuilder: (context, index) => YoutubeVideoListItem(videoInfo: videos[index]),
                  itemCount: videos.length);
            } else if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        )
    );
  }
}