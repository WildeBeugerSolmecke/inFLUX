import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/twitter/twitter_api_client.dart';

void main(){
  test('getting twitter user @solmecke', () async {
    var twitter = TwitterApiClient(bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var user = await twitter.getUserData("solmecke");
    assert(user.name == "Christian Solmecke");
  });

  test('fetching latest @solmecke tweets', () async{
    var twitter = TwitterApiClient(bearerToken: InFluxConfig.twitterApiKey, client: Client());
    var tweets = await twitter.getTweets("solmecke");
    assert(tweets[0].user.name == "Christian Solmecke");
  });
}