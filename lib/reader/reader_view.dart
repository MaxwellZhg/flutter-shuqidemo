import 'package:flutter/material.dart';
import 'package:flutter_shuqi/model/article.dart';
import 'package:flutter_shuqi/reader/reader_utils.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/utility/utility.dart';
import 'package:flutter_shuqi/reader/reader_config.dart';
import 'package:flutter_shuqi/reader/reader_overlayer.dart';
class ReaderView extends StatelessWidget{
  final Article article;
  final int page;
  final double topSafeHeight;


  ReaderView({this.article, this.page, this.topSafeHeight});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(left: 0, top: 0, right: 0, bottom: 0, child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
        ReaderOverlayer(article: article, page: page, topSafeHeight: topSafeHeight),
        buildContent(article, page),
      ],
    );
  }

  buildContent(Article article,int page){
    var content = article.stringAtPageIndex(page);

    if(content.startsWith('\n')){
      content = content.substring(1);
    }
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(15, topSafeHeight+ReaderUtils.topOffset, 10, Screen.bottomSafeHeight + ReaderUtils.bottomOffset),
      child: Text.rich(
          TextSpan(
            children: [TextSpan(
              text: content,
              style: TextStyle(fontSize: fixedFontSize(ReaderConfig.instance.fontSize))
            ),],
          ),
        textAlign: TextAlign.justify,
      ),
    );
  }

}