import 'package:flutter/material.dart';
import 'package:flutter_shuqi/model/novel.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/app/app_navigator.dart';
import 'package:flutter_shuqi/widget/novel_cover_image.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
class NovelGridItem extends StatelessWidget{
  final Novel novel;


  NovelGridItem(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15*2-15)/2;
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: width,
        child: Row(
          children: <Widget>[
           NovelCoverImage(novel.imgUrl,width: 50,height: 50),
           SizedBox(width: 10) ,
           Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(
                     novel.name,
                     maxLines: 2,
                     style: TextStyle(
                       fontSize: 16,
                       height: 0.9,
                       fontWeight: FontWeight.bold
                     ),
                   ),
                   Text(
                     novel.recommendCountStr(),
                     style: TextStyle(
                       fontSize: 12,
                       color: SQColor.red
                     ),
                   )
                 ],
               )
           )
          ],
        ),
      ),
    );
  }

}