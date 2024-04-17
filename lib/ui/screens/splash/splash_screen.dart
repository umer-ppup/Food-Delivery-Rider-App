import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
import 'package:flutter/services.dart';

import '../login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Timer(
        Duration(seconds: 5),
            (){
              checkKey('login').then((value) => {
                if(value == false){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()))
                }
                else if(value == true){
                  checkLoginState(context)
                }
              });
            });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringResources.splashMiddleText,
                  style: TextStyle(
                    fontSize: 28,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.splashFont2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //region spinner to indication loading
                SpinKitWave(
                  color: ColorResources.darkGreyColor,
                  size: 35.0,
                  type: SpinKitWaveType.center,
                ),
                //endregion
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/images/atrule_icon.png',
                      width: 50, height: 50),
                  textRegular(StringResources.companyName, TextAlign.start),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
