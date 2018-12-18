import 'package:influx/utility/youtube/model/thumbnail_resolution.dart';
import 'package:meta/meta.dart';

class YoutubeChannelInfo {
  String title;
  String id;
  String description;
  Map<ThumbnailResolution, String> thumbnailUrls;
  String urlIdentifier;

  YoutubeChannelInfo(
      {@required this.title,
      @required this.id,
      @required this.description,
      @required this.thumbnailUrls,
      @required this.urlIdentifier});
}
