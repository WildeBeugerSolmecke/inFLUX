import 'package:http/http.dart';
import 'package:webfeed/webfeed.dart';

/// A RSS feed reader helper class.
class RssFeedReader {

  final String url;

  RssFeedReader({this.url});

  Future<List<RssItem>> fetchRssPosts() async {
    print('Fetching RSS feed: ' + url + '...');
    var response = await get(url);

    print('Response.statusCode: ' + response.statusCode.toString());
    var feed = RssFeed.parse(response.body);

    print('Feed.items.length: ' + feed.items.length.toString());
    return feed.items;
  }
}
