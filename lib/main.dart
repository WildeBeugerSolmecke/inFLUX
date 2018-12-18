import 'package:flutter/material.dart';
import 'package:influx/config.dart';
import 'package:influx/widgets/base_page.dart';

void main() => runApp(App());

/// The root widget.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: InFluxConfig.title,
      theme: ThemeData(
        primarySwatch: InFluxConfig.primaryColor,
      ),
      home: BasePage(),
    );
  }
}
