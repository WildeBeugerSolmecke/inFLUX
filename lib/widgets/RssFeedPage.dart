import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/RssFeedReader.dart';
import 'package:url_launcher/url_launcher.dart';

/// A widget that displays contents from an RSS feed.
class RssFeedPage extends StatefulWidget {
  final String title;

  // TODO: this should not be injected manually but via a DI framework:
  final RssFeedReader rssFeedReader;

  RssFeedPage({@required this.title, this.rssFeedReader, Key key})
      : super(key: key);

  @override
  _RssFeedState createState() => _RssFeedState(rssFeedReader: rssFeedReader);
}

class _RssFeedState extends State<RssFeedPage> {
  RssFeedReader _rssFeedReader;

  _RssFeedState({rssFeedReader})
      : _rssFeedReader =
            rssFeedReader ?? RssFeedReader(url: InFluxConfig.rssFeedUrl);

  @override
  Widget build(BuildContext context) {
    final maxRssFeedItems = 20;
    var rssPosts = _rssFeedReader.fetchRssPosts(maxRssFeedItems);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var listItems = snapshot.data
                    .map<ListTile>((rssPost) => ListTile(
                          leading: Icon(Icons.arrow_right),
                          title: rssPostTitleToText(rssPost),
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

  GestureTapCallback rssPostUrlToTapCallback(RssPost post) {
    return () => launch(post.url);
  }
}
