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
    final maxRssFeedItems = 20;
    var rssReader = RssFeedReader(url: InFluxConfig.rssFeedUrl);
    var rssPosts = rssReader.fetchRssPosts(maxRssFeedItems);

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
                          // TODO: onClick with link URL!
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
        )
    );
  }

  Text rssPostTitleToText(RssPost post) {
    // TODO: Handle German Umlauts!
    // TODO: Trim string to fit a single line!
    return Text(post.title);
  }
}
