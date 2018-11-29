import 'dart:convert';

import 'package:http/http.dart';
import 'package:influx/utility/Youtube/ThumbnailSize.dart';
import 'package:influx/utility/Youtube/YoutubeChannelInfo.dart';
import 'package:influx/utility/Youtube/YoutubeVideoInfo.dart';

class YoutubeApiAdapter{

  static const YOUTUBE_CHANNEL_API_URL = "https://www.googleapis.com/youtube/v3/channels";
  static const YOUTUBE_SEARCH_API_URL = "https://www.googleapis.com/youtube/v3/search";

  Future<YoutubeChannelInfo> getChannelInfo(final String userName, final String apiKey) async {

    final url = "$YOUTUBE_CHANNEL_API_URL?part=contentDetails,snippet&forUsername=$userName&key=$apiKey";

    var response = await get(url);
    dynamic body = json.decode(response.body);
    // take first element
    dynamic channel = body['items'][0];
    String channelTitle = channel['snippet']['title'];
    String description = channel['snippet']['description'];
    String id = channel['id'];

    // thumbnails
    Map<ThumbnailSize, String> thumbnails = new Map();
    String smallThumbnail = channel['snippet']['thumbnails']['default']['url'];
    thumbnails[ThumbnailSize.SMALL] = smallThumbnail;

    String mediumThumbnail = channel['snippet']['thumbnails']['medium']['url'];
    thumbnails[ThumbnailSize.MEDIUM] = mediumThumbnail;

    String largeThumbnail = channel['snippet']['thumbnails']['high']['url'];
    thumbnails[ThumbnailSize.LARGE] = largeThumbnail;

    YoutubeChannelInfo youtubeChannelInfo = new YoutubeChannelInfo();
    youtubeChannelInfo.title = channelTitle;
    youtubeChannelInfo.description = description;
    youtubeChannelInfo.id = id;
    youtubeChannelInfo.thumbnailUrls = thumbnails;

    return youtubeChannelInfo;
  }

  Future<List<YoutubeVideoInfo>> getVideos(final String channelId, final String apiKey, [final int results = 10]) async {

    final url = "$YOUTUBE_SEARCH_API_URL?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=20&type=video";

    var response = await get(url);

    var body = json.decode(response.body);
    var videosJson  =  body["items"] as List;

    var videos = new List<YoutubeVideoInfo>();

    for(int i = 0; i<videosJson.length; i++){
        YoutubeVideoInfo video = new YoutubeVideoInfo();

        var videoRaw = videosJson[i];

        video.id = videoRaw["id"]["videoId"];
        video.title = videoRaw["snippet"]["title"];
        video.description = videoRaw["snippet"]["description"];
        video.publishedAt = DateTime.parse(videoRaw["snippet"]["publishedAt"] as String);

        video.thumbnailUrls[ThumbnailSize.SMALL] = videoRaw["snippet"]["thumbnails"]["default"]["url"] as String;
        video.thumbnailUrls[ThumbnailSize.MEDIUM] = videoRaw["snippet"]["thumbnails"]["medium"]["url"];
        video.thumbnailUrls[ThumbnailSize.LARGE] = videoRaw["snippet"]["thumbnails"]["high"]["url"];

        videos.add(video);
    }
    return videos;
  }

}