import 'package:flutter/material.dart';
import 'package:influx/widgets/youtube_page/youtube_page_redesign.dart';
import 'package:influx/widgets/youtube_page/youtube_page_clone.dart';

class YoutubePage extends StatefulWidget {
  final String title;
  YoutubePage({@required this.title});

  @override
  _YoutubePageState createState() => _YoutubePageState(title: this.title);
}

class _YoutubePageState extends State<YoutubePage>{

  final String title;
  Choice _selectedChoice = choices[0]; //the state

  _YoutubePageState({@required this.title});

  void _select(Choice choice){
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            PopupMenuButton<Choice>(
              onSelected: ((Choice c) => _select(c)),
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice){
                  return PopupMenuItem<Choice>(
                    child: Text(choice.title),
                    value: choice,
                  );
                }).toList();
              },
            ),
          ],
        ),
        backgroundColor: Colors.black26,
        body: _renderYoutubePage()
    );
  }

  _renderYoutubePage() {
    switch(this._selectedChoice.title){
      case "Youtube Redesign":
        return YoutubePageRedesign();
      case "Youtube Clone":
        return YoutubePageClone();
      default:
        return Center(child: Text("Something went wrong"));
    }
  }
}



class Choice{
  const Choice({@required this.title});
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: "Youtube Redesign"),
  const Choice(title: "Youtube Clone")
];