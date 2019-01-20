import 'package:flutter/material.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:intl/intl.dart';

class TweetItem extends StatelessWidget {

  final Tweet _tweet;
  TweetItem(this._tweet);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          /// name, tag, time
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(_tweet.user.name, style: _userNameTextStyle),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
              Text("@${_tweet.user.screenName}", style: _tweetHeadlineStyle),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
              Text(
                  "\u{00b7} " +
                      _parseToDisplayedFormat(
                          _parseToDateTime(_tweet.createdAt)),
                  style: _tweetHeadlineStyle)
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Text(
            _tweet.fullText,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }

  DateTime _parseToDateTime(String time) =>
      DateFormat("EEE MMM dd HH:mm:ss '+0000' yyyy").parse(time);
  String _parseToDisplayedFormat(DateTime time) =>
      DateFormat("MMM dd").format(time);

  static const _userNameTextStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const _tweetHeadlineStyle =
      TextStyle(fontSize: 14, color: Color(0xff657786));
}
