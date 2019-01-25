import 'package:flutter/material.dart';
import 'package:influx/utility/text_utils.dart';
import 'package:influx/utility/twitter/api_resources/tweet.dart';
import 'package:intl/intl.dart';

class TweetItem extends StatelessWidget {
  final Tweet _tweet;
  TweetItem(this._tweet);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipOval(
              child: Image.network(_tweet.user.profileImageUrlHttps,
                  width: 48, height: 48, alignment: Alignment.topLeft)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(_tweet.user.name, style: _userNameTextStyle),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Text("@${_tweet.user.screenName}",
                        style: _tweetHeadlineStyle),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Text(
                        "\u{00b7} " +
                            _parseToDisplayedFormat(
                                _parseToDateTime(_tweet.createdAt)),
                        style: _tweetHeadlineStyle)
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                TextUtils.buildRichTextWithClickableUrls(
                    _tweet.fullText,
                    _tweet.entities.urls
                        .map((turl) =>
                            UrlInText(turl.indices[0], turl.indices[1]))
                        .toList()),
                Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                (_tweet.entities.media != null)
                    ? Image.network(
                        "${_tweet.entities.media.last.mediaUrlHttps}:medium",
                        height: _tweet.entities.media.last.sizes.medium.height
                                    .toDouble() <
                                400
                            ? _tweet.entities.media.last.sizes.medium.height
                                .toDouble()
                            : 400,
                fit: BoxFit.fitHeight,)
                    : Container()
              ],
            ),
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
