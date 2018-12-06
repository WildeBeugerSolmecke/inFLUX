import 'package:influx/utility/youtube/api_response_dtos/default.dart';
import 'package:influx/utility/youtube/api_response_dtos/high.dart';
import 'package:influx/utility/youtube/api_response_dtos/medium.dart';

class Thumbnails {
  Default low;
  Medium medium;
  High high;

  Thumbnails({this.low, this.medium, this.high});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    low = json['default'] != null ? new Default.fromJson(json['default']) : null;
    medium = json['medium'] != null ? new Medium.fromJson(json['medium']) : null;
    high = json['high'] != null ? new High.fromJson(json['high']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.low != null) {
      data['default'] = this.low.toJson();
    }
    if (this.medium != null) {
    data['medium'] = this.medium.toJson();
    }
    if (this.high != null) {
    data['high'] = this.high.toJson();
    }
    return data;
  }
}