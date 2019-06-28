import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shuqi/utility/event_bus.dart';
import 'package:flutter_shuqi/app/user_manager.dart';
import 'package:flutter_shuqi/app/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shuqi/global.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/bookshelf/bookshelf_scene.dart';
import 'package:flutter_shuqi/home/home_scene.dart';
import 'package:flutter_shuqi/me/me_scene.dart';
class RootScence extends StatefulWidget{
  @override
  RootScenceState createState() {
    // TODO: implement createState
    return RootScenceState();
  }

}

class RootScenceState extends State<RootScence>{
  int _tabIndex = 0;
  bool isFinishSetup = false;
  List<Image> _tabImages = [
    Image.asset('img/tab_bookshelf_n.png'),
    Image.asset('img/tab_bookstore_n.png'),
    Image.asset('img/tab_me_n.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_bookshelf_p.png'),
    Image.asset('img/tab_bookstore_p.png'),
    Image.asset('img/tab_me_p.png'),
  ];
  
  @override
  void initState() {
    super.initState();
    setupApp();
    eventBus.on(EventUserLogin, (arg){
       setState(() {

       });
    });
    eventBus.on(EventUserLoginout, (arg){
      setState(() {

      });
    });
    eventBus.on(EventToggleTabBarIndex, (arg){
      setState(() {
        _tabImages =arg;
      });
    });
  }

  setupApp() async{
    preferences = await SharedPreferences .getInstance();
    setState(() {
       isFinishSetup = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(! isFinishSetup){
      return Container();
    }
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
         BookshelfScence(),
         HomeScene(),
         MeScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
       backgroundColor: Colors.white,
        activeColor: SQColor.primary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), title: Text("书架")),
          BottomNavigationBarItem(icon: getTabIcon(1), title: Text("书城")),
          BottomNavigationBarItem(icon: getTabIcon(2), title: Text("我的")),
        ],
        currentIndex: _tabIndex,

        onTap: (index){
         setState(() {
           _tabIndex =index;
         });
        },
      ),
    );
  }

  Image getTabIcon(int index){
    if(index==_tabIndex){
      return _tabSelectedImages[index];
    }else{
      return _tabImages[index];
    }
  }

}