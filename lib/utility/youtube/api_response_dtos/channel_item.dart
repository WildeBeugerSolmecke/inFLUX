import 'package:influx/utility/youtube/api_response_dtos/channel_snippet.dart';

class ChannelItem {
  String kind;
  String etag;
  String id;
  ChannelSnippet snippet;

  ChannelItem({this.kind, this.etag, this.id, this.snippet});

  ChannelItem.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet = json['snippet'] != null ? new ChannelSnippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
    return data;
  }
}
