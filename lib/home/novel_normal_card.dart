import 'package:flutter/material.dart';
import 'package:flutter_shuqi/model/home_model.dart';
import 'package:flutter_shuqi/home/home_section_view.dart';
import 'package:flutter_shuqi/home/novel_cell.dart';
class NovelNormalCard extends StatelessWidget{
   final HomeModule cardInfo;

   NovelNormalCard(this.cardInfo);

  @override
  Widget build(BuildContext context) {
    var novels = cardInfo.books;

    if(novels.length<3){
      return null;
    }

    List<Widget> children = [
      HomeSectionView(cardInfo.name),
    ];

    for (var i = 0;i<novels.length;i++){
      var novel = novels[i];
      children.add(NovelCell(novel));
      children.add(Divider(height: 1));
    }
    children.add(
        Container(height: 10,color: Color(0xfff5f5f5)
        )
    );
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }


}