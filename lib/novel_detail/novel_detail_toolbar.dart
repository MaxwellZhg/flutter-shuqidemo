import 'package:flutter/material.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/model/novel.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/app/app_navigator.dart';
import 'package:flutter_shuqi/utility/Styles.dart';

class NovelDetailToolbar extends StatelessWidget{
  final Novel novel;

  NovelDetailToolbar(this.novel);
  read(){

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
      decoration: BoxDecoration(color: Colors.white,boxShadow: Styles.borderShadow),
      height: 50+Screen.bottomSafeHeight,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Center(
                child: Text(
                  '加书架',
                  style: TextStyle(fontSize: 16,color: SQColor.primary),
                ),
              ),
          ),
          Expanded(
              child: GestureDetector(
                onTap: (){
                  AppNavigator.pushReader(context, novel.firstArticleId);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: SQColor.primary,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Text(
                      '开始阅读',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
              )
          ),

          Expanded(
              child: Center(
                child: Text(
                  '下载',
                  style: TextStyle(fontSize: 16,color: SQColor.primary),
                ),
              )
          )
        ],
      ),
    );
  }

}