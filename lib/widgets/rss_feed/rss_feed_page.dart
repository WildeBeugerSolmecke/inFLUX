import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/rss_feed/rss_feed_reader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

/// A widget that displays contents from an RSS feed.
class RssFeedPage extends StatefulWidget {
  final RssFeedReader rssFeedReader;
  const RssFeedPage({this.rssFeedReader, Key key}) : super(key: key);

  @override
  _RssFeedState createState() => _RssFeedState(rssFeedReader: rssFeedReader);
}

class _RssFeedState extends State<RssFeedPage> {
  final int _maxRssFeedItems = 20;
  final _formatter = DateFormat('dd.MM.yyyy HH:mm:ss');

  final RssFeedReader _rssFeedReader;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int _lastRssFeedIndex = 0;
  List<RssPost> _rssPosts = List();

  _RssFeedState({RssFeedReader rssFeedReader})
      : _rssFeedReader =
            rssFeedReader ?? RssFeedReader(url: InFluxConfig.rssFeedUrl);

  @override
  initState() {
    super.initState();
    _scrollController.addListener(_handleScrolling);
  }

  @override
  Widget build(BuildContext context) {
    final rssPosts = _rssFeedReader.fetchRssPostsFromIndex(
        _lastRssFeedIndex, _maxRssFeedItems);

    return Material(
        child: Center(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ensure that no duplicates were fetched:
            final snapshotData = snapshot.data as List<RssPost>;
            final distinctData = snapshotData
                .where((post) => !(_rssPosts.contains(post)))
                .toList();
            _rssPosts.addAll(distinctData);
            _lastRssFeedIndex = _rssPosts.length;

            final listItems = _rssPosts
                .map<ListTile>((rssPost) => ListTile(
                      title: _rssPostTitleToText(rssPost),
                      subtitle: _pubDate(rssPost),
                      onTap: _rssPostUrlToTapCallback(rssPost),
                    ))
                .toList();
            return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshRssFeed,
                child: ListView(
                  children: listItems,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                ));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");

          } else {
            return CircularProgressIndicator();
          }
        },
        future: rssPosts,
      ),
    ));
  }

  Text _rssPostTitleToText(RssPost post) {
    return Text(post.title);
  }

  Text _pubDate(RssPost post) {
    final defaultText = Text("");
    if (post != null && post.pubDate != null) {
      try {
        final date = _formatter.format(post.pubDate);
        return Text(date);
      } catch (e) {
        return defaultText;
      }
    } else {
      return defaultText;
    }
  }

  GestureTapCallback _rssPostUrlToTapCallback(RssPost post) {
    return () => launch(post.url);
  }

  void _handleScrolling() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      // trigger builder:
      setState(() {});
    }
  }

  Future<void> _refreshRssFeed() async {
    setState(() {
      _lastRssFeedIndex = 0;
      _rssPosts.clear();
    });
  }
}
