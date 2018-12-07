import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:webfeed/webfeed.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/// A RSS feed reader helper class.
class RssFeedReader {
  final String url;
  RssFeed Function(String xmlString) rssFeedParser;
  http.Client httpClient;
  static final defaultRssFeedParser = (xmlString) => RssFeed.parse(xmlString);

  /// A constructor that allows to override the default implementations.
  RssFeedReader({@required this.url, rssFeedParser, httpClient})
      : rssFeedParser = rssFeedParser ?? defaultRssFeedParser,
        httpClient = httpClient ?? http.Client();

  /// Fetches (a maximum of 'maxItems') RSS feed posts. Returns a future!
  Future<List<RssPost>> fetchRssPosts(int maxItems) async {
    var response = await httpClient.get(url);
    var feed = rssFeedParser(response.body);

    var n = min(feed.items.length, maxItems);
    return feed.items
        .sublist(0, n)
        .map((rssItem) => RssPost(title: rssItem.title, url: rssItem.link, pubDate: DateTime.parse(rssItem.pubDate)))
        .toList();

    // TODO: add some kind of pagination!
  }

  DateTime parseRssDate(String dateString) {
    // TODO: extract substring(s)!
    var date = DateTime.parse(dateString);
    return date;
  }
}

/// Encapsulates all necessary information about an RSS post, thereby hiding the
/// 'RssItem' class (which is an implementation detail) from callers.
class RssPost {
  final String title;
  final String url;
  final DateTime pubDate;

  RssPost({@required this.title, this.url, this.pubDate});
}
