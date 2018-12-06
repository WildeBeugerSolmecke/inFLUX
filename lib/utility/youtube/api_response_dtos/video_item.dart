import 'package:influx/utility/youtube/api_response_dtos/id.dart';
import 'package:influx/utility/youtube/api_response_dtos/video_snippet.dart';

class VideoItem {
  String kind;
  String etag;
  Id id;
  VideoSnippet snippet;

  VideoItem({this.kind, this.etag, this.id, this.snippet});

  VideoItem.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    snippet = json['snippet'] != null ? new VideoSnippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
    return data;
  }
}