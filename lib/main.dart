import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: InFluxConfig.title,
      theme: ThemeData(
        primarySwatch: InFluxConfig.primaryColor,
      ),
      home: MyHomePage(),
    );
  }
}
