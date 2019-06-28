import 'package:flutter/material.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/app/root_scene.dart';
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class AppScene extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Shuqi',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xffeeeeee),
        scaffoldBackgroundColor: SQColor.paper,
        textTheme: TextTheme(
          body1: TextStyle(color: SQColor.darkGray)
        )
      ),
      home: RootScence(),
    );
  }

}