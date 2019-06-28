import 'package:flutter/material.dart';
import 'package:flutter_shuqi/model/novel.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/widget/novel_cover_image.dart';
import 'package:flutter_shuqi/app/app_navigator.dart';
import 'package:flutter_shuqi/home/home_scene.dart';
class BookshelfItemView extends StatelessWidget{
  final Novel novel;

  BookshelfItemView(this.novel);

  @override
  Widget build(BuildContext context) {
     var width = (Screen.width -15*2-24*2)/3;
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>HomeScene(),
            )
        );
      },
      child: Container(
        width: width,
        child: Stack(
          children: <Widget>[
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                DecoratedBox(
                    child: NovelCoverImage(
                      novel.imgUrl,
                      width: width,
                      height: width/0.75,
                    ),
                    decoration: BoxDecoration(
                      boxShadow:[BoxShadow(color: Color(0x22000000),blurRadius: 5)] ,
                    ),
                ),
                Text("11111",style: TextStyle(color: Color(0xffff0000)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(novel.name,style: TextStyle(fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis),
            SizedBox(height: 25),
          ],
        ),
           Positioned(bottom: 0,child:Text("111111",style: TextStyle(color: Color(0xffff0000))))
          ],

        ),
        /*child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DecoratedBox(
                child: NovelCoverImage(
                    novel.imgUrl,
                    width: width,
                    height: width/0.75,
                ),
                decoration: BoxDecoration(
                  boxShadow:[BoxShadow(color: Color(0x22000000),blurRadius: 5)] ,
                )
            ),
            SizedBox(
              height: 10,
            ),
            Text(novel.name,style: TextStyle(fontSize: 14),maxLines: 1,overflow: TextOverflow.ellipsis),
            SizedBox(height: 25)
          ],
        ),*/
      ),
    );
  }

}