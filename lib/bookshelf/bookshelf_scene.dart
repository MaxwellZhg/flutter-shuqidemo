import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shuqi/model/novel.dart';
import 'package:flutter_shuqi/app/app_scene.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/app/request.dart';
import 'package:flutter_shuqi/utility/toast.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/bookshelf/bookshelf_item_view.dart';
import 'package:flutter_shuqi/bookshelf/bookshelf_header.dart';
class BookshelfScence extends StatefulWidget{
  @override
  BookshelfState createState() {
    // TODO: implement createState
    return BookshelfState();
  }

}

class BookshelfState extends State<BookshelfScence> with RouteAware{
  List<Novel> favoriteNovels = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  @override
  void initState() {
    fetchData();
    super.initState();
    //处理头部影藏显示
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> fetchData() async{
    try{
      List<Novel> favoriteNovels = [];
      List<dynamic> favoriteResponse = await Request.get(action: 'bookshelf');
      favoriteResponse.forEach((data){
        favoriteNovels.add(Novel.fromJson(data));
      });
      setState(() {
        this.favoriteNovels =favoriteNovels;
      });
    } catch (e){
      Toast.show(e.toString());
    }
  }
  Widget buildActions(Color iconColor){
    return Row(
      children: <Widget>[
        Container(
          height: kToolbarHeight,
          width: 44,
          child: Image.asset('img/actionbar_checkin.png', color: iconColor),
        ),
        Container(
          height: kToolbarHeight,
          width: 44,
          child: Image.asset('img/actionbar_search.png', color: iconColor),
        ),
        SizedBox(width: 15)
      ],
    );
  }

  Widget buildNavigationBar(){
    return Stack(
      children: <Widget>[
        Positioned(
            right: 0,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
              child: buildActions(SQColor.white),
            ),
        ),
        Opacity(
            opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            color: SQColor.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 103),
                Expanded(
                    child: Text(
                      '书架',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    )
                ),
                buildActions(SQColor.darkGray),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFavoriteView(){
    if(favoriteNovels.length <=1){
      return Container();
    }
    List<Widget> children = [];
    var novels = favoriteNovels.sublist(1);
    novels .forEach((novel){
      children.add(BookshelfItemView(novel));
    });
    var width = (Screen.width -15*2-24)/3;
    //添加+号的部分
    children.add(GestureDetector(
        onTap: (){

        },
      child: Container(
        color: SQColor.paper,
        width: width,
        height: width/0.75,
        child: Image.asset('img/bookshelf_add.png'),
       ),
      ),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Wrap(
        spacing: 23,
        children: children,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SQColor.white ,
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
              onRefresh: fetchData,
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                controller: scrollController,
                children: <Widget>[
                  favoriteNovels.length >0?BookshelfHeader(favoriteNovels[0]):Container(),
                  buildFavoriteView(),
                ],
              ),
          ),
          buildNavigationBar(),
        ],
      ),
    );
  }

}