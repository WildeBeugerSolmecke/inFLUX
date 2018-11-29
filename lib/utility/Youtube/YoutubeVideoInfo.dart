import 'package:influx/utility/Youtube/ThumbnailSize.dart';

class YoutubeVideoInfo{
  String id;
  String title;
  String description;
  DateTime publishedAt;
  Map<ThumbnailSize, String> thumbnailUrls = new Map();
}