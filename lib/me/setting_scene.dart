import 'package:flutter/material.dart';
import 'package:flutter_shuqi/app/sq_color.dart';
import 'package:flutter_shuqi/app/user_manager.dart';

class SettingScene extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if(UserManager.instance.isLogin){
      children.add(GestureDetector(
        onTap: (){

        },
        child: Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Text('退出登录',style: TextStyle(fontSize: 16,color: SQColor.red)),
          ),
        ),
      )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        elevation: 0.5,
      ),
      body: Container(
        child: ListView(
          children: children,
        ),
      ),
    );
  }

}