import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/RssFeedPage.dart';

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
              icon: Icon(Icons.home), title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('YT Channel')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('RSS Feed')
          ),
        ],
        currentIndex: _navbarIndex,
        fixedColor: Colors.blue,
        onTap: _onNavBarTap,
      ),
    );
  }

  void _onNavBarTap(int index) {
    setState(() {
      _navbarIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          // TODO: The routes should be generated as well (see above)!
            builder: (context) => RssFeedPage(
                  title: widget.title,
                )),
        // TODO: Don't navigate to a new page via "MaterialPageRoute" (which
        // TODO: creates an ugly arrow in the upper left corner), rather change
        // TODO: the CONTENT of the Center()!
      );
    });
  }
}
