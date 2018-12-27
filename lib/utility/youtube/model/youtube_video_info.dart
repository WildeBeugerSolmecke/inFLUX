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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is YoutubeVideoInfo &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              description == other.description &&
              publishedAt == other.publishedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      publishedAt.hashCode ^
      thumbnailUrls.hashCode;



}
