import 'package:flutter/material.dart';
import 'package:flutter_shuqi/widget/novel_cover_image.dart';
import 'package:flutter_shuqi/model/novel.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/utility/Styles.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/bookshelf/bookshelf_cloud_widget.dart';
class BookshelfHeader extends StatefulWidget{
  final Novel novel;


  BookshelfHeader(this.novel);

  @override
  BookshelfHeaderState createState() {
    // TODO: implement createState
    return BookshelfHeaderState();
  }

}

class BookshelfHeaderState extends State<BookshelfHeader> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration:const Duration(milliseconds: 2000),vsync: this);
    animation = Tween(begin: 0.0 , end: 1.0).animate(controller);
    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status==AnimationStatus.dismissed){
        controller.forward();
      }
      controller.forward();
    });
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  Widget buildContent(BuildContext context) {
    Novel novel =this.widget.novel;
    var width =Screen.width;
    var height = Screen.topSafeHeight+250;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 54+Screen.topSafeHeight, 10, 0),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: (){
          
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
                child: NovelCoverImage(novel.imgUrl,width: 120,height: 160),
                decoration: BoxDecoration(
                  boxShadow: Styles.borderShadow
                ),
            ),
            SizedBox(width: 20),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(novel.name, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text("读至0.2%     继续阅读",style: TextStyle(fontSize: 14,color: SQColor.paper)),
                        Image.asset('img/bookshelf_continue_read.png')
                      ],
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    var bgHeight = width /0.9;
    var height = Screen.topSafeHeight+250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: height -bgHeight ,
            child: Image.asset(
              'img/bookshelf_bg.png',
              fit: BoxFit.cover,
              width: width,
              height: bgHeight,
            ),
          ),
          Positioned(
              bottom: 0,
              child: BookshelfCloudWidget(
                animation: animation,
                width: width,
              )
          ),
          buildContent(context),
        ],
      ),
    );
  }

}