import 'package:influx/utility/youtube/api_response_dtos/video_item.dart';
import 'package:influx/utility/youtube/api_response_dtos/page_info.dart';

class VideoListResponse {
  String kind;
  String etag;
  String nextPageToken;
  String regionCode;
  PageInfo pageInfo;
  List<VideoItem> items;

  VideoListResponse({this.kind, this.etag, this.nextPageToken, this.regionCode, this.pageInfo, this.items});

  VideoListResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    regionCode = json['regionCode'];
    pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      items = new List<VideoItem>();
      json['items'].forEach((v) { items.add(new VideoItem.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['nextPageToken'] = this.nextPageToken;
    data['regionCode'] = this.regionCode;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}