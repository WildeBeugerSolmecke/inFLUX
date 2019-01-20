import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:influx/utility/twitter/twitter_api_client.dart';
import 'package:influx/widgets/generic/infinity_scroll_list_id_based.dart';
import 'package:influx/widgets/twitter/tweet_item.dart';

class TwitterPage extends StatefulWidget {
  final TwitterApiClient client =
      TwitterApiClient(bearerToken: InFluxConfig.twitterApiKey);

  @override
  State<StatefulWidget> createState() => TwitterPageState();
}

class TwitterPageState extends State<TwitterPage> {
  @override
  Widget build(BuildContext context) {
    return InfinityScrollListIdBased<Tweet>(
      dataSupplierIdBased: ({int size, String olderThanId}) => this
          .widget
          .client
          .getTweets(
              twitterName: InFluxConfig.twitterName,
              olderThanId: olderThanId,
              count: size),
      idExtractor: (tweet) => tweet.idStr,
      renderItem: (tweet) => TweetItem(tweet),
      batchSize: 20,
    );
  }


}
