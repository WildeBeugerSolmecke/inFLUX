import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/rss_feed_page.dart';
import 'package:influx/widgets/youtube_page/youtube_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The home page (that get's displayed on app start).
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = InFluxConfig.appBarTitle;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navbarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: Show a (yet to be created) widget at this place, that
            // TODO: aggregates all different information channels!
            Text(
              '[Info feed]',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // TODO: The nav bar must be extracted into a new class, so it can a) be
        // TODO: reused easily and b) get generated according to different needs!
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.youtube), title: Text('Youtube')),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.rss), title: Text('RSS Feed')),
        ],
        currentIndex: _navbarIndex,
        fixedColor: Colors.blue,
        onTap: _onNavBarTap,
      ),
    );
  }

  void _onNavBarTap(int index) {
    print('index: $index');
    setState(() {
      _navbarIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
                // TODO: The routes should be generated as well (see above)!
                builder: (context) => YoutubePage(
                      title: widget.title,
                    )),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
                // TODO: The routes should be generated as well (see above)!
                builder: (context) => RssFeedPage(
                      title: widget.title,
                    )),
          );
        // TODO: Don't navigate to a new page via "MaterialPageRoute" (which
        // TODO: creates an ugly arrow in the upper left corner), rather change
        // TODO: the CONTENT of the Center()!
      }
    });
  }
}
