import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:influx/utility/twitter/api_resources/serializers.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:influx/utility/twitter/api_resources/user.dart';
import 'package:influx/utility/twitter/twitter_user_data.dart';
import 'package:influx/config.dart';

class TwitterApiClient{
  final String bearerToken;
  final Client client;
  static final Client defaultClient = Client();

  TwitterApiClient({@required this.bearerToken, Client client}) : this.client = client ?? defaultClient;

  Future<TwitterUserData> getUserData(String twitterName) async {
    final uri = new Uri(scheme: "https",
        host: "api.twitter.com",
        path: "1.1/users/show.json",
        queryParameters: {'screen_name': twitterName});
    Response response = await this.client.get(uri,
        headers: {"Authorization": "Bearer ${InFluxConfig.twitterApiKey}"});
    dynamic body = json.decode(response.body);
    var user = serializers.deserializeWith(User.serializer, body);
    return TwitterUserData(name: user.name,
        followerCount: user.followersCount,
        imageUrl: user.profileImageUrlHttps,
        tweetsCount: user.statusesCount,
        twitterTag: user.screenName,
        bannerUrl: user.profileBannerUrl);
  }

  Future<List<Tweet>> getTweets({@required String twitterName, int count = 20, int olderThanId}) async {

    var queryParameters = {'screen_name': twitterName, 'tweet_mode': 'extended', 'count' : count.toString(), 'include_rts': 'false', 'exclude_replies':'true'};
    if(olderThanId!=null) queryParameters.addAll({"max_id": (olderThanId-1).toString()});

    final uri = new Uri(
        scheme: "https",
        host: "api.twitter.com",
        path: "1.1/statuses/user_timeline.json",
        queryParameters: queryParameters);

    Response response = await this.client.get(uri, headers: {'Authorization': 'Bearer ${InFluxConfig.twitterApiKey}'});
    if(response.statusCode != 200) throw new Exception("response code was ${response.statusCode} but expected 200");
    List<dynamic> body = json.decode(response.body);
    return ListBuilder<Tweet>(body.map((tweet) => serializers.deserializeWith(Tweet.serializer, tweet))).build().toList();
  }
}