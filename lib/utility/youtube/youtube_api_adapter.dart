import 'dart:convert';
import 'package:http/http.dart';
import 'package:influx/utility/youtube/api_response_dtos/channel_info_response.dart';
import 'package:influx/utility/youtube/api_response_dtos/serializers.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_list_response.dart';
import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:influx/utility/youtube/model/youtube_channel_with_videos.dart';
import 'package:influx/utility/youtube/model/youtube_channel_info.dart';
import 'package:influx/utility/youtube/model/youtube_video_info.dart';
import 'package:meta/meta.dart';

/// [YoutubeApiAdapter] wraps Youtube API Client logic to retrieve
/// [YoutubeChannelInfo] and [YoutubeVideoInfo] from the API.
class YoutubeApiAdapter {
  static const YOUTUBE_CHANNEL_API_URL =
      "https://www.googleapis.com/youtube/v3/channels";
  static const YOUTUBE_SEARCH_API_URL =
      "https://www.googleapis.com/youtube/v3/search";

  static final defaultHttpClient = Client();
  final Client httpClient;

  /// Creates new YoutubeApiAdapter with the defined [client] or the [defaultHttpClient]
  /// if no [client] was specified
  YoutubeApiAdapter({Client client}) : httpClient = client ?? defaultHttpClient;

  /// Queries the youtube api for channel info and most recent uploaded videos
  /// of a youtube-channel defined by [channelId].
  Future<YoutubeChannelWithVideos> getYoutubeChannelAndVideos(
      {@required final String channelId,
      @required final String apiKey,
      final int maxResults = 10}) async {
    List responses = await Future.wait([
      getChannelInfo(
          channelId: channelId, apiKey: apiKey),
      getVideos(
          channelId: channelId,
          maxResults: 10,
          apiKey: apiKey)
    ]);

    return YoutubeChannelWithVideos(
        channel: responses[0], videos: responses[1]);
  }

  /// Queries the youtube api for channel info for a given youtube channel
  /// defined by the [channelId].
  Future<YoutubeChannelInfo> getChannelInfo(
      {@required final String channelId, @required final String apiKey}) async {
    final url =
        "$YOUTUBE_CHANNEL_API_URL?part=contentDetails,snippet&id=$channelId&key=$apiKey";

    var response = await httpClient.get(url);

    if (response.statusCode != 200)
      throw new Exception(
          "status code for request $url was ${response.statusCode} but expected 200");

    dynamic body = json.decode(response.body);
    var channelInfoResponse =
        serializers.deserializeWith(ChannelInfoResponse.serializer, body);
    // take first element
    var channel = channelInfoResponse.items[0];
    String channelTitle = channel.snippet.title;
    String description = channel.snippet.description;
    String urlIdentifier = channel.snippet.customUrl;
    String id = channel.id;

    // thumbnails
    Map<ThumbnailResolution, String> thumbnails = Map();

    thumbnails[ThumbnailResolution.LOW] = channel.snippet.thumbnails.low.url;
    thumbnails[ThumbnailResolution.MEDIUM] =
        channel.snippet.thumbnails.medium.url;
    thumbnails[ThumbnailResolution.HIGH] = channel.snippet.thumbnails.high.url;

    return YoutubeChannelInfo(
        id: id,
        description: description,
        thumbnailUrls: thumbnails,
        title: channelTitle,
        urlIdentifier: urlIdentifier);
  }

  /// returns the most recent videos uploaded by a youtube channel
  Future<List<YoutubeVideoInfo>> getVideos(
      {@required final String channelId,
      @required final String apiKey,
      final int maxResults = 10,
      final DateTime since}) async {

    // TODO URLBuilder
    var url =
        "$YOUTUBE_SEARCH_API_URL?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=20&type=video";

    if(since != null){
      url += "&publishedAfter=" + since.toIso8601String().toString();
    }

    final response = await httpClient.get(url);

    if (response.statusCode != 200)
      throw new Exception(
          "status code for request $url was ${response.statusCode} but expected 200");

    final body = json.decode(response.body);
    final videoList =
        serializers.deserializeWith(VideoListResponse.serializer, body);

    final videos = videoList.items;

    return videos.map((video) {
      final String id = video.id.videoId;
      final String title = video.snippet.title;
      final String description = video.snippet.description;
      final DateTime publishedAt = DateTime.parse(video.snippet.publishedAt);

      Map<ThumbnailResolution, String> thumbnails = new Map();
      thumbnails[ThumbnailResolution.LOW] = video.snippet.thumbnails.low.url;
      thumbnails[ThumbnailResolution.MEDIUM] =
          video.snippet.thumbnails.medium.url;
      thumbnails[ThumbnailResolution.HIGH] = video.snippet.thumbnails.high.url;

      return YoutubeVideoInfo(
          id: id,
          title: title,
          description: description,
          publishedAt: publishedAt,
          thumbnailUrls: thumbnails);
    }).toList();
  }
}
