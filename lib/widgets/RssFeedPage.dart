import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/utility/RssFeedReader.dart';

/// A widget that displays contents from an RSS feed.
class RssFeedPage extends StatefulWidget {
  final String title;

  RssFeedPage({Key key, this.title}) : super(key: key);

  @override
  _RssFeedState createState() => _RssFeedState();
}

class _RssFeedState extends State<RssFeedPage> {
  @override
  Widget build(BuildContext context) {
    var rssReader = RssFeedReader(url: InFluxConfig.rssFeedUrl);
    var posts = rssReader.fetchRssPosts();

    // TODO: posts.then(...);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          // TODO: see above!
        ],
      ),
    );
  }
}
