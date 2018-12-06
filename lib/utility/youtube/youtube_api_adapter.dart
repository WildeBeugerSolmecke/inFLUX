import 'dart:convert';
import 'package:http/http.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_info_response.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_list_response.dart';
import 'package:influx/utility/youtube/model/thumbnail_size.dart';
import 'package:influx/utility/youtube/model/youtube_channel_with_videos.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:meta/meta.dart';

class YoutubeApiAdapter {
  static const YOUTUBE_CHANNEL_API_URL =
      "https://www.googleapis.com/youtube/v3/channels";
  static const YOUTUBE_SEARCH_API_URL =
      "https://www.googleapis.com/youtube/v3/search";

  Future<YoutubeChannelWithVideos> getYoutubeChannelAndVideos(
      {@required Client httpClient,
      @required final String channelId,
      @required final String apiKey,
      final int maxResults = 10}) async {
    List responses = await Future.wait([
      getChannelInfo(
          httpClient: httpClient, channelId: channelId, apiKey: apiKey),
      getVideos(
          httpClient: httpClient,
          channelId: channelId,
          maxResults: 10,
          apiKey: apiKey)
    ]);

    return YoutubeChannelWithVideos(
        channel: responses[0], videos: responses[1]);
  }

  Future<YoutubeChannelInfo> getChannelInfo(
      {@required Client httpClient,
      @required final String channelId,
      @required final String apiKey}) async {
    final url =
        "$YOUTUBE_CHANNEL_API_URL?part=contentDetails,snippet&id=$channelId&key=$apiKey";

    var response = await httpClient.get(url);

    if (response.statusCode != 200)
      throw new Exception(
          "status code for request $url was ${response.statusCode} but expected 200");

    dynamic body = json.decode(response.body);
    var youtubeChannelInfo = ChannelInfoResponse.fromJson(body);
    // take first element
    var channel = youtubeChannelInfo.items[0];
    String channelTitle = channel.snippet.title;
    String description = channel.snippet.description;
    String urlIdentifier = channel.snippet.customUrl;
    String id = channel.id;

    // thumbnails
    Map<ThumbnailResolution, String> thumbnails = Map();

    thumbnails[ThumbnailResolution.LOW] = channel.snippet.thumbnails.low.url;
    thumbnails[ThumbnailResolution.MEDIUM] =  channel.snippet.thumbnails.medium.url;
    thumbnails[ThumbnailResolution.HIGH] = channel.snippet.thumbnails.high.url;

    return YoutubeChannelInfo(
        id: id,
        description: description,
        thumbnailUrls: thumbnails,
        title: channelTitle,
        urlIdentifier: urlIdentifier);
  }

  Future<List<YoutubeVideoInfo>> getVideos(
      {@required Client httpClient,
      @required final String channelId,
      @required final String apiKey,
      final int maxResults = 10}) async {
    final url =
        "$YOUTUBE_SEARCH_API_URL?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=20&type=video";

    var response = await httpClient.get(url);

    if (response.statusCode != 200)
      throw new Exception(
          "status code for request $url was ${response.statusCode} but expected 200");

    var body = json.decode(response.body);
    VideoListResponse videoList = VideoListResponse.fromJson(body);

    var videos = videoList.items;

    return videos.map((video) {
      String id = video.id.videoId;
      String title = video.snippet.title;
      String description = video.snippet.description;
      DateTime publishedAt = DateTime.parse(video.snippet.publishedAt);

      Map<ThumbnailResolution, String> thumbnails = new Map();
      thumbnails[ThumbnailResolution.LOW] =
          video.snippet.thumbnails.low.url;
      thumbnails[ThumbnailResolution.MEDIUM] =
          video.snippet.thumbnails.medium.url;
      thumbnails[ThumbnailResolution.HIGH] =
          video.snippet.thumbnails.high.url;

      return YoutubeVideoInfo(
          id: id,
          title: title,
          description: description,
          publishedAt: publishedAt,
          thumbnailUrls: thumbnails);
    }).toList();
  }
}
