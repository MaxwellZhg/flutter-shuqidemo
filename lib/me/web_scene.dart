import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WebScene extends StatefulWidget{
  final String url;
  final String title;


  WebScene({this.url, this.title});

  @override
  WebSceneState createState() {
    // TODO: implement createState
    return WebSceneState();
  }

}

class WebSceneState extends State<WebScene>{
  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
        url: null,
        appBar:AppBar(
          title: Text(this.widget.title??'Demo'),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Share.share(this.widget.url);
              },
              child: Image.asset('img/icon_menu_share.png'),
            )
          ],
        ) ,
    );
  }

}