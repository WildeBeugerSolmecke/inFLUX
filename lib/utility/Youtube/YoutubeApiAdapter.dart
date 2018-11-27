import 'dart:convert';

import 'package:http/http.dart';
import 'package:influx/utility/Youtube/YoutubeChannelInfo.dart';

class YoutubeApiAdapter{

  Future<YoutubeChannelInfo> getChannelInfo(final String userName, final String apiKey) async {
    const YOUTUBE_CHANNEL_API_URL = "https://www.googleapis.com/youtube/v3/channels";
    final url = "$YOUTUBE_CHANNEL_API_URL?part=contentDetails,snippet&forUsername=$userName&key=$apiKey";

    var response = await get(url);
    dynamic body = json.decode(response.body);
    // take first element
    dynamic channel = body['items'][0];
    String channelTitle = channel['snippet']['title'];
    String description = channel['snippet']['description'];
    String id = channel['id'];

    // thumbnails
    Map<Size, String> thumbnails = new Map();
    String smallThumbnail = channel['snippet']['thumbnails']['default']['url'];
    thumbnails[Size.SMALL] = smallThumbnail;

    String mediumThumbnail = channel['snippet']['thumbnails']['medium']['url'];
    thumbnails[Size.MEDIUM] = mediumThumbnail;

    String largeThumbnail = channel['snippet']['thumbnails']['high']['url'];
    thumbnails[Size.LARGE] = largeThumbnail;

    YoutubeChannelInfo youtubeChannelInfo = new YoutubeChannelInfo();
    youtubeChannelInfo.title = channelTitle;
    youtubeChannelInfo.description = description;
    youtubeChannelInfo.id = id;
    youtubeChannelInfo.thumbnails = thumbnails;

    return youtubeChannelInfo;
  }
}