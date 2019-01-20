import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/twitter/api_resources/serializers.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:influx/utility/twitter/twitter_api_client.dart';
import 'package:intl/intl.dart';

import 'json/demo_tweet.dart';

void main(){
  test('getting twitter user @solmecke', () async {
    var twitter = TwitterApiClient(bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var user = await twitter.getUserData("solmecke");
    assert(user.name == "Christian Solmecke");
  });

  test('fetching latest @solmecke tweets', () async{
    var twitter = TwitterApiClient(bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var tweets = await twitter.getTweets(twitterName: "solmecke", count: 10,olderThanId: "1086227593605668864");
    assert(tweets.length == 10);
    assert(tweets[0].user.name == "Christian Solmecke");
  });

  test('parsing date from twitter api', (){
    DateTime format(String date) => DateFormat("EEE MMM dd HH:mm:ss '+0000' yyyy").parseUTC(date);
    String date = "Fri Jan 18 13:43:19 +0000 2016";
    DateTime formatted = format(date);
    assert(formatted.day == 18);
    assert(formatted.year == 2016);
  });

  test('Get all links off a text and return RichText widget',(){
    Tweet tweet = serializers.deserializeWith(Tweet.serializer, json.decode(DemoTweet.json));
    assert(tweet.user.screenName == "solmecke");
  });
}