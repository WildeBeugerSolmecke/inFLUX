import 'package:flutter/material.dart';
import 'package:influx/utility/twitter/twitter_user_data.dart';

class TwitterApiClient{
  final String bearerToken;

  TwitterApiClient({@required this.bearerToken});

  Future<TwitterUserData> getUserData(String twitterTag){
    return Future.delayed(Duration(seconds: 1));
  }
}