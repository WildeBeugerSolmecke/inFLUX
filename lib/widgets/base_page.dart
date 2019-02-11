import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/influx_navigator.dart';

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
