import 'package:flutter/material.dart';

class TwitterUserData {
  String name;
  String twitterTag;
  int followerCount;
  int tweetsCount;
  String imageUrl;
  String bannerUrl;

  TwitterUserData(
      {@required this.name,
      @required this.twitterTag,
      @required this.followerCount,
      @required this.tweetsCount,
      @required this.imageUrl,
      this.bannerUrl});
}
