import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class YoutubePage extends StatelessWidget{

  final String title;

  YoutubePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterYoutube.playYoutubeVideoByUrl(apiKey: "AIzaSyBlzbF2a_6k3njt_jC5t43Di0vIcAjyQts", videoUrl: "https://www.youtube.com/watch?v=E7jwPMxJMfo");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Colors.red,
      body: new Center(
        child: new Text("Youtube Page", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic),),
      ),
    );
  }

}