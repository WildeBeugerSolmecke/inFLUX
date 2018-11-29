import 'package:influx/utility/Youtube/thumbnail_size.dart';
import 'package:meta/meta.dart';

class YoutubeVideoInfo{
  String id;
  String title;
  String description;
  DateTime publishedAt;
  Map<ThumbnailSize, String> thumbnailUrls = new Map();

  YoutubeVideoInfo({@required this.id, @required this.title, @required this.description, @required this.publishedAt,
      @required this.thumbnailUrls});


}