import 'package:influx/utility/youtube/api_response_dtos/localized.dart';
import 'package:influx/utility/youtube/api_response_dtos/thumbnails.dart';

class ChannelSnippet {
  String title;
  String description;
  String customUrl;
  String publishedAt;
  Thumbnails thumbnails;
  Localized localized;

  ChannelSnippet({this.title, this.description, this.customUrl, this.publishedAt, this.thumbnails, this.localized});

  ChannelSnippet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    customUrl = json['customUrl'];
    publishedAt = json['publishedAt'];
    thumbnails = json['thumbnails'] != null ? new Thumbnails.fromJson(json['thumbnails']) : null;
    localized = json['localized'] != null ? new Localized.fromJson(json['localized']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['customUrl'] = this.customUrl;
    data['publishedAt'] = this.publishedAt;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
    if (this.localized != null) {
      data['localized'] = this.localized.toJson();
    }
    return data;
  }
}