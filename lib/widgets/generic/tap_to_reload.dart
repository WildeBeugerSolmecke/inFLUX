import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:influx/config.dart';

class TapToReload extends StatelessWidget{

  final Function onTap;

  const TapToReload({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(heightFactor: 5.0,
        child: GestureDetector(
          onTap: () => onTap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  "Oops, we were unable to fetch the required data", style: TextStyle(fontSize: 18.0),),
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.arrowAltCircleDown,
                      color: InFluxConfig.primaryColor, size: 22),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                  Text("Tap to reload",
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        )
    );
  }

}