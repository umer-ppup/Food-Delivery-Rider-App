import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/ui/screens/home/home_screen.dart';
import 'package:food_rider_app/ui/screens/splash/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: ColorResources.whiteColor,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

