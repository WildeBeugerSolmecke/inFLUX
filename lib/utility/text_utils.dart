import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextUtils{

  /// TODO: mehrere links direkt hintereinander
  static RichText buildRichTextWithClickableUrls(String text, List<UrlInText> urls){

    var length = text.runes.length;
    urls.sort((a, b) => a.beginIndex < b.beginIndex ? -1 : 1);
    var spans = <TextSpan>[TextSpan(text: text, style: defaultTextStyle)];
    /// is always on the first character after the last url: e.g. "xxlinkxxxxxx" would be 6.
    int sliceBeginIndex = 0;

    for (UrlInText urlInText in urls) {
      // is url is right at the beginning of the last slice
      if (urlInText.beginIndex == sliceBeginIndex) {
        spans[spans.length-1] = _buildTextSpan(
            _substring(text, urlInText.beginIndex, urlInText.endIndex),
            isUrl: true);
        spans.add(_buildTextSpan(
            _substring(text, urlInText.endIndex+1)
        ));
        sliceBeginIndex = urlInText.endIndex + 1;
      }
      // if url is at the end
      else if(urlInText.endIndex == length){
        spans[spans.length-1] = _buildTextSpan(_substring(text, sliceBeginIndex, urlInText.beginIndex-1));
        spans.add(_buildTextSpan(_substring(text, urlInText.beginIndex, urlInText.endIndex), isUrl: true));
      }
      // url is somewhere in the middle
      else{
        spans[spans.length-1] = _buildTextSpan(_substring(text, sliceBeginIndex, urlInText.beginIndex));
        spans.add(_buildTextSpan(_substring(text, urlInText.beginIndex, urlInText.endIndex), isUrl: true));
        spans.add(_buildTextSpan(_substring(text, urlInText.endIndex+1)));
        sliceBeginIndex = urlInText.endIndex + 1;
      }
    }
    return RichText(text: TextSpan(children: spans));
  }
}

TextStyle defaultTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

TextStyle linkTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.blue,
);

TapGestureRecognizer _lauchUrlOnClick(String launchUrl) =>
    TapGestureRecognizer()..onTap = () => launch(launchUrl);

TextSpan _buildTextSpan(String text, {TextStyle style, bool isUrl = false}) {
  return TextSpan(
      text: text,
      style: isUrl ? linkTextStyle : defaultTextStyle,
      recognizer: isUrl ? _lauchUrlOnClick(text) : null,);
}

/// [begin] beginning of the substring (inclusive)
/// [end] end of the substring (exclusive)
String _substring(String text, int begin, [int end = -1]){
  var runes = text.runes.toList();
  return (end<0) ? String.fromCharCodes(runes.sublist(begin)) : String.fromCharCodes(runes.sublist(begin, end));
}

class UrlInText {
  int beginIndex;
  int endIndex;

  UrlInText(this.beginIndex, this.endIndex);
}