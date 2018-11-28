import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'dart:math';

/// A RSS feed reader helper class.
class RssFeedReader {
  final String url;
  RssFeed Function(String xmlString) rssFeedParser;
  http.Client httpClient;
  static final defaultRssFeedParser = (xmlString) => RssFeed.parse(xmlString);

  /// Default constructor.
  RssFeedReader({this.url})
      : rssFeedParser = defaultRssFeedParser,
        httpClient = http.Client();

  /// A secondary constructor that allows to override the default implementations.
  RssFeedReader.build({this.url, this.rssFeedParser, this.httpClient});

  /// Fetches (a maximum of 'maxItems') RSS feed posts. Returns a future!
  Future<List<RssPost>> fetchRssPosts(int maxItems) async {
    print('Fetching RSS feed: ' + url + '...');
    var response = await httpClient.get(url);

    print('Response.statusCode: ' + response.statusCode.toString());
    var feed = rssFeedParser(response.body);

    var n = min(feed.items.length, maxItems);
    return feed.items
        .sublist(0, n)
        .map((rssItem) => RssPost(title: rssItem.title))
        .toList();

    // TODO: add some kind of pagination!
  }
}

/// Encapsulates all necessary information about an RSS post, thereby hiding the
/// 'RssItem' class (which is an implementation detail) from callers.
class RssPost {
  final String title;

  RssPost({this.title});
}
