import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:webfeed/webfeed.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/// A RSS feed reader helper class.
class RssFeedReader {
  final String url;
  final RssFeed Function(String xmlString) rssFeedParser;
  final http.Client httpClient;
  static final defaultRssFeedParser = (xmlString) => RssFeed.parse(xmlString);

  /// A constructor that allows to override the default implementations.
  RssFeedReader(
      {@required this.url,
      RssFeed Function(String xmlString) rssFeedParser,
      http.Client httpClient})
      : rssFeedParser = rssFeedParser ?? defaultRssFeedParser,
        httpClient = httpClient ?? http.Client();

  /// Fetches (a maximum of 'maxItems') RSS feed posts. Returns a future!
  Future<List<RssPost>> fetchRssPosts(int maxItems) async {
    final response = await httpClient.get(url);
    final feed = rssFeedParser(response.body);

    // RSS items HAVE TO have at least a title and a URL:
    final validItems = feed.items
        .where((rssItem) => (rssItem.title != null && rssItem.title.isNotEmpty))
        .where((rssItem) => (rssItem.link != null && rssItem.link.isNotEmpty))
        .toList();

    final n = min(validItems.length, maxItems);
    return validItems
        .sublist(0, n)
        .map((rssItem) => RssPost(
            title: rssItem.title,
            url: rssItem.link,
            pubDate: parseRssDate(rssItem.pubDate)))
        .toList();

    // TODO: add some kind of pagination!
  }

  /// Parses a common RSS feed date (e.g. 'Sat, 17 Nov 2018 05:50:14 GMT')
  /// to a valid Dart DateTime object.
  DateTime parseRssDate(String dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    } else {
      final length = dateString.length;
      final substr = dateString.substring(5).substring(0, length - 5 - 4);

      // formatter for e.g.:     '07 Dec 2018 15:49:56'
      final formatter = DateFormat('dd MMM yyyy HH:mm:ss');
      return formatter.parse(substr);
    }
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
