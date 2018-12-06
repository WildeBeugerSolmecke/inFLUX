import 'package:influx/utility/youtube/api_response_dtos/thumbnails.dart';

class VideoSnippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String liveBroadcastContent;

  VideoSnippet({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent});

  VideoSnippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null ? new Thumbnails.fromJson(json['thumbnails']) : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    return data;
  }
}