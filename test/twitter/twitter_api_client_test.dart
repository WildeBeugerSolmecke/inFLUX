import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/text_utils.dart';
import 'package:influx/utility/twitter/api_resources/serializers.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:influx/utility/twitter/twitter_api_client.dart';
import 'package:intl/intl.dart';

import 'json/demo_tweet.dart';

void main() {
  test('getting twitter user @solmecke', () async {
    var twitter = TwitterApiClient(
        bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var user = await twitter.getUserData("solmecke");
    expect(user.name, "Christian Solmecke");
  });

  test('fetching @solmecke tweets older than tweet with id 1086227593605668864', () async {
    var twitter = TwitterApiClient(
        bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var tweets = await twitter.getTweets(twitterName: "solmecke", count: 10, olderThanId: 1086227593605668864);

    tweets.forEach((tweet) => expect(tweet.user.name, "Christian Solmecke"));
  });

  test('parsing date from twitter api', () {
    DateTime format(String date) =>
        DateFormat("EEE MMM dd HH:mm:ss '+0000' yyyy").parseUTC(date);
    String date = "Fri Jan 18 13:43:19 +0000 2016";
    DateTime formatted = format(date);
    expect(formatted.day, 18);
    expect(formatted.year, 2016);
  });

  test('Get all links off a text and return RichText widget', () {
    Tweet tweet = serializers.deserializeWith(
        Tweet.serializer, json.decode(DemoTweet.json));
    var urls = tweet.entities.urls
        .map((turl) => UrlInText(turl.indices[0], turl.indices[1]));
  });
}


