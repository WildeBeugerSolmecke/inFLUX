import 'package:influx/utility/youtube/api_response_dtos/channel_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/page_info.dart';

class ChannelInfoResponse {
  String kind;
  String etag;
  PageInfo pageInfo;
  List<ChannelItem> items;

  ChannelInfoResponse({this.kind, this.etag, this.pageInfo, this.items});

  ChannelInfoResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      items = new List<ChannelItem>();
      json['items'].forEach((v) { items.add(new ChannelItem.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}