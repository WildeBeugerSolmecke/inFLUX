import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:meta/meta.dart';

class YoutubeVideoInfo {
  String id;
  String title;
  String description;
  DateTime publishedAt;
  Map<ThumbnailResolution, String> thumbnailUrls = new Map();

  YoutubeVideoInfo(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.publishedAt,
      @required this.thumbnailUrls});
}
