import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/rss_feed/rss_feed_reader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

/// A widget that displays contents from an RSS feed.
class RssFeedPage extends StatefulWidget {

  // TODO: this should not be injected manually but via a DI framework:
  final RssFeedReader rssFeedReader;

  const RssFeedPage({this.rssFeedReader, Key key})
      : super(key: key);

  @override
  _RssFeedState createState() => _RssFeedState(rssFeedReader: rssFeedReader);
}

class _RssFeedState extends State<RssFeedPage> {
  final RssFeedReader _rssFeedReader;
  final formatter = DateFormat('dd.MM.yyyy HH:mm:ss');

  _RssFeedState({rssFeedReader})
      : _rssFeedReader =
            rssFeedReader ?? RssFeedReader(url: InFluxConfig.rssFeedUrl);

  @override
  Widget build(BuildContext context) {
    final maxRssFeedItems = 20;
    final rssPosts = _rssFeedReader.fetchRssPosts(maxRssFeedItems);

    return Material(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final listItems = snapshot.data
                    .map<ListTile>((rssPost) => ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: rssPostTitleToText(rssPost),
                          subtitle: pubDate(rssPost),
                          onTap: rssPostUrlToTapCallback(rssPost),
                        ))
                    .toList();
                return ListView(
                  children: listItems,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}"); // TODO: Hide error details!

              } else {
                return CircularProgressIndicator();
              }
            },
            future: rssPosts,
          ),
        ));
  }

  Text rssPostTitleToText(RssPost post) {
    // TODO: Trim string to fit a single line!
    return Text(post.title);
  }

  Text pubDate(RssPost post) {
    final date = formatter.format(post.pubDate);
    return Text(date);
  }

  GestureTapCallback rssPostUrlToTapCallback(RssPost post) {
    return () => launch(post.url);
  }
}
