import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_rider_app/models/order_history.dart';
import 'package:food_rider_app/models/shift_model.dart';
import 'package:food_rider_app/models/transaction_history.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/ui/screens/home/home_screen.dart';
import 'package:food_rider_app/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

//region function to store a boolean into shared preferences
addBoolToSF(String key, bool c) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, c);
}
//endregion

//region function to read a boolean from shared preferences
Future<bool> getBoolValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool boolValue = prefs.getBool(key) ?? false;
  return boolValue;
}
//endregion

//region function to check key contains inside shared preferences
Future<bool> checkKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool b = false;
  if(prefs.containsKey(key)){
    b = true;
  }
  return b;
}
//endregion

//region splash screen to next screen navigator function
Future checkLoginState(BuildContext context) async {
  if (await getBoolValuesSF('login')) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }
  else{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}
//endregion

//region api call function to fetch json data
Future readJson(String url, String type) async {
  if (StringResources.isOnline) {
    return https.get(Uri.parse(url)).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      // if (type == "restaurantData") {
      //   return RestaurantModel.fromJson(json.decode(response.body));
      // } else if (type == "orderData") {
      //   return OrderModel.fromJson(json.decode(response.body));
      // } else if (type == "addressData") {
      //   return AddressModel.fromJson(json.decode(response.body));
      // } else if (type == "reviewData") {
      //   return Review.fromJson(json.decode(response.body));
      // }
    });
  }
  else {
    List dataList = [];

    final String response = await rootBundle.loadString("asset/data.json");
    var data = await json.decode(response);

    if (type == "orderHistoryData") {
      var result = data["orderHistoryData"] as List;
      dataList = result
          .map<OrderHistory>((json) => OrderHistory.fromJson(json))
          .toList();
    } else if (type == "transactionData") {
      var result = data["transactionData"] as List;
      dataList = result
          .map<TransactionHistory>((json) => TransactionHistory.fromJson(json))
          .toList();
    }
    else if (type == "shiftData") {
      var result = data["shiftData"] as List;
      dataList = result
          .map<ShiftModel>((json) => ShiftModel.fromJson(json))
          .toList();
    }
      // } else if (type == "addressData") {
      //   var result = data["addressData"] as List;
      //   dataList = result
      //       .map<AddressModel>((json) => AddressModel.fromJson(json))
      //       .toList();
      // } else if (type == "reviewData") {
      //   var result = data["reviewData"] as List;
      //   dataList = result
      //       .map<Review>((json) => Review.fromJson(json))
      //       .toList();
      // }

      return dataList;
    }
}
//endregion

//region longin post request function
Future loginPostRequest(String url, {required Map body}) async {
  if(StringResources.isOnline){
    return https.post(Uri.parse(url), body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    // Secrets.prefs = await SharedPreferences.getInstance();
    // Secrets.prefs.setString('userInfo',body.toString());
  }
}
//endregion

//region signUp post request function
Future signUpPostRequest(String url, {required Map body}) async {
  if(StringResources.isOnline){
    return https.post(Uri.parse(url), body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    // Secrets.prefs = await SharedPreferences.getInstance();
    // Secrets.prefs.setString('userInfo',body.toString());
  }
}
//endregion

//region input focus change function
void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
//endregion

//region open map with directions code
Future<void> launchMaps(String sLat, String sLog, String dLat, String dLog) async {
  String googleUrl = 'https://www.google.com/maps/dir/$sLat,$sLog/$dLat,$dLog';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    Fluttertoast.showToast(
        msg: "Error: Could not open the map.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.heartColor,
        textColor: ColorResources.whiteColor,
        fontSize: 16.0
    );
  }
}
//endregion

//region storage write and read code
class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.txt');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }
}
//endregion

//region check rider is in his riding area before start its shif
bool checkIfValidPosition(LatLng tap, List<LatLng> vertices) {
  int intersectCount = 0;
  for (int j = 0; j < vertices.length - 1; j++) {
    if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
      intersectCount++;
    }
  }

  return ((intersectCount % 2) == 1); // odd = inside, even = outside;
}

bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
  double aY = vertA.latitude;
  double bY = vertB.latitude;
  double aX = vertA.longitude;
  double bX = vertB.longitude;
  double pY = tap.latitude;
  double pX = tap.longitude;

  if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
    return false; // a and b can't both be above or below pt.y, and a or
    // b must be east of pt.x
  }

  double m = (aY - bY) / (aX - bX); // Rise over run
  double bee = (-aX) * m + aY; // y = mx + b
  double x = (pY - bee) / m; // algebra is neat!

  return x > pX;
}
//endregion

//region open call dialog with phone number
Future<void> launchCallDialor(String number) async {
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  if (!res!) {
    Fluttertoast.showToast(
        msg: "Error: Could not open dialor.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.heartColor,
        textColor: ColorResources.whiteColor,
        fontSize: 16.0
    );
  }
}
//endregion