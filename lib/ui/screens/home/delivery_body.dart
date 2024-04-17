import 'package:flutter/material.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:progress_dialog/progress_dialog.dart';

class DeliveryBody extends StatefulWidget {
  @override
  _DeliveryBodyState createState() => _DeliveryBodyState();
}

class _DeliveryBodyState extends State<DeliveryBody> {
  //region Dialog form related variables
  final _formKeyRestaurant = GlobalKey<FormState>();
  TextEditingController cCode = TextEditingController();
  FocusNode _codeFocusNode = FocusNode();

  final _formKeyCustomer = GlobalKey<FormState>();
  TextEditingController cAmount = TextEditingController();
  FocusNode _amountFocusNode = FocusNode();

  final _formKeyComplaint = GlobalKey<FormState>();
  TextEditingController cComplaint = TextEditingController();
  FocusNode _complaintFocusNode = FocusNode();
  //endregion

  //region order status variables
  bool orderCame = true;
  bool restaurant = false;
  bool customer = false;
  bool empty = false;
  //endregion

  //region function to Open Map to get direction from current position to restaurant/customer location
  Future openMapForRouteDirection(String dLat, String dLog) async {
    // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        // await pr.hide();
        return;
      }
      else{
        getLocation(dLat, dLog);
      }
    }
    else{
      getLocation(dLat, dLog);
    }
  }
  Future getLocation(String dLat, String dLog) async {
    // await pr.show();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // await pr.hide();
    launchMaps(position.latitude.toString(), position.longitude.toString(), dLat, dLog);
  }
  //endregion

  //region popup bottom sheet code
  void settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext mContext, StateSetter setState) {
                return Container(
                  color: ColorResources.whiteColor,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          StringResources.confirmItemText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorResources.darkGreyColor,
                            fontFamily: FontResources.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(bottom: 66.0),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return orderItemWidget(
                                context,
                                "Pizza",
                                "2"
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    return empty == false ? Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //region code when order came
                  Visibility(
                    visible: orderCame,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.0,
                          color: ColorResources.smokeWhiteColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        color: ColorResources.smokeWhiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              StringResources.restaurantNameText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: ColorResources.darkGreyColor,
                                fontFamily: FontResources.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            "asset/images/location.png",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                              color: ColorResources.dodgerBlueColor,
                              onPressed: (){
                                setState(() {
                                  orderCame = false;
                                  restaurant = true;
                                  customer = false;
                                  empty = false;
                                });
                              },
                              child: Text(
                                  StringResources.acceptOrderText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorResources.whiteColor,
                                    fontFamily: FontResources.bold,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //endregion

                  //region code when restaurant details came after accepting order
                  Visibility(
                    visible: restaurant,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.0,
                          color: ColorResources.smokeWhiteColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        color: ColorResources.smokeWhiteColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                StringResources.goToRestaurant,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ColorResources.dodgerBlueColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Name:", TextAlign.center),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  textRegular("Pizza Hut", TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Address:", TextAlign.start),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: textRegular("Plot #15, Block N Phase 2 Johar Town, Lahore, Punjab", TextAlign.start)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      FlatButton(
                                        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                        color: ColorResources.dodgerBlueColor,
                                        onPressed: (){
                                          openMapForRouteDirection("31.469622","74.275481");
                                        },
                                        child: Icon(
                                          Icons.map_rounded,
                                          color: ColorResources.whiteColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Phone Number:", TextAlign.start),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: textRegular("12345678910", TextAlign.start)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      FlatButton(
                                        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                        color: ColorResources.dodgerBlueColor,
                                        onPressed: (){
                                          launchCallDialor("12345678910");
                                        },
                                        child: Icon(
                                          Icons.call_rounded,
                                          color: ColorResources.whiteColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Order Id:", TextAlign.center),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  textRegular("123506", TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Note:", TextAlign.center),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: textBold("Please confirm items before pick up", TextAlign.start)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      FlatButton(
                                        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                        color: ColorResources.dodgerBlueColor,
                                        onPressed: (){
                                          settingModalBottomSheet();
                                        },
                                        child: Text(
                                            "ITEMS",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: ColorResources.whiteColor,
                                              fontFamily: FontResources.bold,
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                color: ColorResources.dodgerBlueColor,
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        //region pop up dialog code
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 0,
                                          backgroundColor: ColorResources.whiteColor,
                                          child: Form(
                                            key: _formKeyRestaurant,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      focusNode: _codeFocusNode,
                                                      controller: cCode,
                                                      textInputAction: TextInputAction.none,
                                                      autofocus: false,
                                                      keyboardType: TextInputType.number,
                                                      obscureText: false,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorResources.darkGreyColor,
                                                        fontFamily: FontResources.regular,
                                                      ),
                                                      cursorColor: ColorResources.darkGreyColor,
                                                      decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
                                                        alignLabelWithHint: true,
                                                        labelText: "Enter Code",
                                                        labelStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: ColorResources.dodgerBlueColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                        suffixIcon: Icon(Icons.add, color: ColorResources.dodgerBlueColor,),
                                                      ),
                                                      validator: (value){
                                                        if (value!.isEmpty) {
                                                          return 'Please enter code.';
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                      onSaved: (value){
                                                        StringResources.restaurantCode = value!;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: FlatButton(
                                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                                        color: ColorResources.dodgerBlueColor,
                                                        onPressed: (){
                                                          if (_formKeyRestaurant.currentState!.validate()) {
                                                            _formKeyRestaurant.currentState!.save();
                                                            Navigator.of(context).pop();
                                                            setState(() {
                                                              orderCame = false;
                                                              restaurant = false;
                                                              customer = true;
                                                              empty = false;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                            "PICKED UP",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: ColorResources.whiteColor,
                                                              fontFamily: FontResources.bold,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        //endregion
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                      "PICKED UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.whiteColor,
                                        fontFamily: FontResources.bold,
                                      )
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //endregion

                  //region code when customer details came after picking order from the restaurant
                  Visibility(
                    visible: customer,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.0,
                          color: ColorResources.smokeWhiteColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        color: ColorResources.smokeWhiteColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Go To The Customer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: ColorResources.dodgerBlueColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Name:", TextAlign.center),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  textRegular("Abc Xyz", TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Address:", TextAlign.start),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: textRegular("House #5, Street #7, Johar Town, Lahore, Punjab", TextAlign.start)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      FlatButton(
                                        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                        color: ColorResources.dodgerBlueColor,
                                        onPressed: (){
                                          openMapForRouteDirection("31.469622","74.275481");
                                        },
                                        child: Icon(
                                          Icons.map_rounded,
                                          color: ColorResources.whiteColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Phone Number:", TextAlign.start),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: textRegular("12345678910", TextAlign.start)),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      FlatButton(
                                        //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                        color: ColorResources.dodgerBlueColor,
                                        onPressed: (){
                                          launchCallDialor("12345678910");
                                        },
                                        child: Icon(
                                          Icons.call_rounded,
                                          color: ColorResources.whiteColor,
                                          size: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: ColorResources.dodgerBlueColor,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBold("Amount:", TextAlign.center),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  textRegular("280 Rs.", TextAlign.center),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                color: ColorResources.dodgerBlueColor,
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        //region pop up dialog code
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 0,
                                          backgroundColor: ColorResources.whiteColor,
                                          child: Form(
                                            key: _formKeyCustomer,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      focusNode: _amountFocusNode,
                                                      controller: cAmount,
                                                      textInputAction: TextInputAction.none,
                                                      autofocus: false,
                                                      keyboardType: TextInputType.number,
                                                      obscureText: false,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorResources.darkGreyColor,
                                                        fontFamily: FontResources.regular,
                                                      ),
                                                      cursorColor: ColorResources.darkGreyColor,
                                                      decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
                                                        alignLabelWithHint: true,
                                                        labelText: "Confirm Amount",
                                                        labelStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: ColorResources.dodgerBlueColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                                        suffixIcon: Icon(Icons.attach_money_rounded, color: ColorResources.dodgerBlueColor,),
                                                      ),
                                                      validator: (value){
                                                        if (value!.isEmpty) {
                                                          return 'Please enter collected amount.';
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                      onSaved: (value){
                                                        StringResources.confirmAmount = value!;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: FlatButton(
                                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                                        color: ColorResources.dodgerBlueColor,
                                                        onPressed: (){
                                                          if (_formKeyCustomer.currentState!.validate()) {
                                                            _formKeyCustomer.currentState!.save();
                                                            print(StringResources.confirmAmount);
                                                            Navigator.of(context).pop();
                                                            setState(() {
                                                              orderCame = false;
                                                              restaurant = false;
                                                              customer = false;
                                                              empty = true;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                            "CONFIRM",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: ColorResources.whiteColor,
                                                              fontFamily: FontResources.bold,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        //endregion
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                      "DELIVERED",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.whiteColor,
                                        fontFamily: FontResources.bold,
                                      )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                color: ColorResources.dodgerBlueColor,
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        //region pop up dialog code
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 0,
                                          backgroundColor: ColorResources.whiteColor,
                                          child: Form(
                                            key: _formKeyComplaint,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      focusNode: _complaintFocusNode,
                                                      controller: cComplaint,
                                                      textInputAction: TextInputAction.none,
                                                      autofocus: false,
                                                      maxLines: 5,
                                                      maxLength: 200,
                                                      keyboardType: TextInputType.multiline,
                                                      obscureText: false,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorResources.darkGreyColor,
                                                        fontFamily: FontResources.regular,
                                                      ),
                                                      cursorColor: ColorResources.darkGreyColor,
                                                      decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: ColorResources.dodgerBlueColor,
                                                          ),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
                                                        alignLabelWithHint: true,
                                                        counterStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorResources.heartColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        labelText: "Complaint",
                                                        labelStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: ColorResources.darkGreyColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        hintText: "Please write details of failure...",
                                                        hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          color: ColorResources.lightGreyColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                      ),
                                                      validator: (value){
                                                        if (value!.isEmpty) {
                                                          return 'Please write some details of failure.';
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                      onSaved: (value){
                                                        StringResources.failureReason = value!;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: FlatButton(
                                                        padding: EdgeInsets.symmetric(vertical: 10.0),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                                        color: ColorResources.dodgerBlueColor,
                                                        onPressed: (){
                                                          if (_formKeyComplaint.currentState!.validate()) {
                                                            _formKeyComplaint.currentState!.save();
                                                            Navigator.of(context).pop();
                                                            setState(() {
                                                              orderCame = false;
                                                              restaurant = false;
                                                              customer = false;
                                                              empty = true;
                                                            });
                                                          }
                                                        },
                                                        child: Text(
                                                            "SAVE",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: ColorResources.whiteColor,
                                                              fontFamily: FontResources.bold,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        //endregion
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                      "FAILED",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.whiteColor,
                                        fontFamily: FontResources.bold,
                                      )
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  //endregion
                ],
              ),
            ),
          ),
        ),
      ),
    ) : Container(
      child: Center(
        child: textBold("No order yet!", TextAlign.center),
      ),
    );
  }
}
