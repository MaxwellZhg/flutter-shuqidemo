import 'package:flutter/material.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/home/home_list_view.dart';
class HomeScene extends StatefulWidget{
  @override
  HomeSceneState createState() {
    // TODO: implement createState
    return HomeSceneState();
  }
  
}

class HomeSceneState extends State<HomeScene>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            title: Container(
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: <Widget>[
                     Text("111"),
              Container(
                width: 230,
                 child:
                     TabBar(
                   labelColor: SQColor.darkGray ,
                   labelStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                   unselectedLabelColor: SQColor.gray,
                   indicatorColor: SQColor.secondary,
                   indicatorSize: TabBarIndicatorSize.label,
                   indicatorWeight: 3,
                   //indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                   tabs:  [
                     Tab(text: '精选'),
                     Tab(text: '女生'),
                     Tab(text: '男生'),
                     Tab(text: '漫画'),
                   ],
                 ),
              ),
                     Text("111"),
                   ],
              ),
         /*     padding: EdgeInsets.symmetric(horizontal: 15),
              child: TabBar(
                  labelColor: SQColor.darkGray ,
                  labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  unselectedLabelColor: SQColor.gray,
                  indicatorColor: SQColor.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  //indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                  tabs:  [
                    Tab(text: '精选'),
                    Tab(text: '女生'),
                    Tab(text: '男生'),
                    Tab(text: '漫画'),
                  ],
              ),*/
            ),
            backgroundColor: SQColor.white,
            elevation: 0,
          ),
          body: TabBarView(
              children: [
                HomeListView(HomeListType.excellent),
                HomeListView(HomeListType.female),
                HomeListView(HomeListType.male),
                HomeListView(HomeListType.cartoon),
              ]
          ),
        ));
  }
  
}