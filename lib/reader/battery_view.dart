import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:flutter_shuqi/app/sq_color.dart';

class BatteryView extends StatefulWidget{
  @override
  BatteryViewState createState() {
    // TODO: implement createState
    return BatteryViewState();
  }

}

class BatteryViewState extends State<BatteryView>{
  double batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    getBatteryLevel();
  }

  getBatteryLevel() async{
    //电量
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      var androidInfo = await deviceInfo.androidInfo;
      if(!androidInfo.isPhysicalDevice){
           return;
      }
    }
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      if (!iosInfo.isPhysicalDevice) {
        return;
      }
    }

    var level = await Battery().batteryLevel;
    setState(() {
      this.batteryLevel = level / 100.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 12,
      child: Stack(
        children: <Widget>[
          Image.asset('img/reader_battery.png'),
          Container(
            margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
            width: 20 * batteryLevel,
            color: SQColor.golden,
          )
        ],
      ),
    );
  }

}