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

  /// Fetches (a maximum of 'maxItems') RSS feed posts.
  Future<List<RssPost>> fetchRssPosts(int maxItems) async {
    return fetchRssPostsFromIndex(0, maxItems);
  }

  /// Fetches (a maximum of 'maxItems') RSS feed posts starting at index 'index'.
  Future<List<RssPost>> fetchRssPostsFromIndex(int index, int maxItems) async {
    final response = await httpClient.get(url);
    final feed = rssFeedParser(response.body);

    // RSS items HAVE TO have at least a title, a URL and a guid:
    final validItems = feed.items
        .where((rssItem) => (rssItem.title != null && rssItem.title.isNotEmpty))
        .where((rssItem) => (rssItem.link != null && rssItem.link.isNotEmpty))
        .where((rssItem) => (rssItem.guid != null && rssItem.guid.isNotEmpty))
        .toList();

    final l = validItems.length - index;
    final minItemCount = min(l, maxItems);
    final end = minItemCount + index;

    if (index > end) {
      return List<RssPost>();
    } else {
      return validItems
          .sublist(index, end)
          .map((rssItem) => RssPost(
              guid: rssItem.guid,
              title: rssItem.title,
              url: rssItem.link,
              pubDate: parseRssDate(rssItem.pubDate)))
          .toList();
    }
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
  final String guid;
  final String title;
  final String url;
  final DateTime pubDate;

  RssPost(
      {@required this.guid,
      @required this.title,
      @required this.url,
      this.pubDate});

  @override
  bool operator ==(o) => o is RssPost && this.guid == o.guid;

  @override
  int get hashCode => guid.hashCode;
}
