import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YoutubeAppBar extends AppBar {
  YoutubeAppBar({Key key, String channelName})
      : super(
            key: key,
            backgroundColor: Colors.white,
            title: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.youtube,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "YouTube - ",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: -1.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    channelName != null
                        ? Text(
                            channelName,
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: -1.0,
                                fontWeight: FontWeight.w700),
                          )
                        : null
                  ].where((widget) => widget != null).toList(),
                )));
}
