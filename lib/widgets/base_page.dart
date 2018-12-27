import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/rss_feed_page.dart';
import 'package:influx/widgets/youtube_page/youtube_page.dart';
import 'package:influx/widgets/youtube_page/youtube_page_clone.dart';

class BasePage extends StatefulWidget {
  const BasePage({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  var _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(InFluxConfig.appBarTitle))),
      body: InFluxNavigator.render(_curIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: InFluxNavigator.pages.map((page) => BottomNavigationBarItem(icon: page.icon, title: Text(page.name))).toList(),
        onTap: (index) => _onTap(index),
        currentIndex: _curIndex,
      )
    );
  }

  void _onTap(int index){
    this.setState(() => _curIndex = index);
  }
}

class InFluxNavigator{
  static final pages = <Page>[
    Page(index: 0, name: 'Youtube', body: YoutubePageClone(), icon: Icon(FontAwesomeIcons.youtube)),
    Page(index: 1, name: 'Rss Fees',body: RssFeedPage(), icon: Icon(FontAwesomeIcons.rss))
  ];

  static final render = (int index) => pages.where((page) => page.index == index).map((page)=> page.body).single;
}

class Page{
  final int index;
  final String name;
  final Widget body;
  final Icon icon;

  const Page({@required this.index, @required this.name, @required this.body, @required this.icon}) :
        assert(body!=null), assert(name!=null), assert(index>=0), assert(icon!=null);
}
