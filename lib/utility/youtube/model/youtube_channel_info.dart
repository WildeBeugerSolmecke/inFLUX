import 'package:influx/utility/Youtube/model/thumbnail_size.dart';
import 'package:meta/meta.dart';

class YoutubeChannelInfo {
  String title;
  String id;
  String description;
  Map<ThumbnailSize, String> thumbnailUrls;
  String urlIdentifier;

  YoutubeChannelInfo({@required this.title, @required this.id, @required this.description, @required this.thumbnailUrls, @required this.urlIdentifier});
}
