import 'dart:convert';

import 'package:http/http.dart';
import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:influx/utility/Youtube/youtube_channel_info.dart';
import 'package:influx/utility/Youtube/youtube_video_info.dart';
import 'package:meta/meta.dart';

class YoutubeApiAdapter {
  static const YOUTUBE_CHANNEL_API_URL =
      "https://www.googleapis.com/youtube/v3/channels";
  static const YOUTUBE_SEARCH_API_URL =
      "https://www.googleapis.com/youtube/v3/search";

  Future<YoutubeChannelInfo> getChannelInfo({@required final String userName,
      @required final String apiKey}) async {
    final url =
        "$YOUTUBE_CHANNEL_API_URL?part=contentDetails,snippet&forUsername=$userName&key=$apiKey";

    var response = await get(url);
    dynamic body = json.decode(response.body);
    // take first element
    dynamic channel = body['items'][0];
    String channelTitle = channel['snippet']['title'];
    String description = channel['snippet']['description'];
    String id = channel['id'];

    // thumbnails
    Map<ThumbnailSize, String> thumbnails = Map();
    String smallThumbnail = channel['snippet']['thumbnails']['default']['url'];
    thumbnails[ThumbnailSize.SMALL] = smallThumbnail;

    String mediumThumbnail = channel['snippet']['thumbnails']['medium']['url'];
    thumbnails[ThumbnailSize.MEDIUM] = mediumThumbnail;

    String largeThumbnail = channel['snippet']['thumbnails']['high']['url'];
    thumbnails[ThumbnailSize.LARGE] = largeThumbnail;

    return YoutubeChannelInfo(
        id: id,
        channelTitle: channelTitle,
        description: description,
        thumbnailUrls: thumbnails,
        title: channelTitle);
  }

  Future<List<YoutubeVideoInfo>> getVideos({@required final String channelId,
      @required final String apiKey, final int results = 10}) async {
    final url =
        "$YOUTUBE_SEARCH_API_URL?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=20&type=video";

    var response = await get(url);

    var body = json.decode(response.body);
    List videosJson = body["items"];

    return videosJson.map((videoRaw) {

      String id = videoRaw["id"]["videoId"];
      String title = videoRaw["snippet"]["title"];
      String description = videoRaw["snippet"]["description"];
      DateTime publishedAt =
          DateTime.parse(videoRaw["snippet"]["publishedAt"]);

      Map<ThumbnailSize, String> thumbnails = new Map();
      thumbnails[ThumbnailSize.SMALL] =
      videoRaw["snippet"]["thumbnails"]["default"]["url"];
      thumbnails[ThumbnailSize.MEDIUM] =
      videoRaw["snippet"]["thumbnails"]["medium"]["url"];
      thumbnails[ThumbnailSize.LARGE] =
      videoRaw["snippet"]["thumbnails"]["high"]["url"];

      return YoutubeVideoInfo(id: id, title: title, description: description, publishedAt: publishedAt, thumbnailUrls: thumbnails);
    }).toList();
  }
}
