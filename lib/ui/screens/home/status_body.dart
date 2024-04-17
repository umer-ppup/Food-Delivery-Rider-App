import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_rider_app/models/dropdown_item.dart';
import 'package:food_rider_app/models/shift_model.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StatusBody extends StatefulWidget {
  @override
  _StatusBodyState createState() => _StatusBodyState();
}

class _StatusBodyState extends State<StatusBody> {
  String status = "Not Available";
  bool accept = false;
  DropdownItem? selectedVehicle, selectedBox;
  final _formKey = GlobalKey<FormState>();

  List<DropdownItem> vehicle = <DropdownItem>[
    DropdownItem('Motorbike', Icons.delivery_dining)
  ];
  List<DropdownItem> box = <DropdownItem>[
    DropdownItem('Standard Box', Icons.all_inbox)
  ];

  List<LatLng> _area = [
    LatLng(31.471600490522185, 74.27767731249332),
    LatLng(31.478339389178036, 74.27618265151978),
    LatLng(31.480173651272818, 74.28100023418665),
    LatLng(31.478309651819064, 74.28172241896391),
    LatLng(31.475359315709156, 74.28056605160236)];

  //region function to Open Map to get direction from current position to restaurant/customer location
  Future checkLocation() async {
    // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        // await pr.hide();
        return;
      }
      else{
        getLocation();
      }
    }
    else{
      getLocation();
    }
  }
  Future getLocation() async {
    // await pr.show();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // await pr.hide();
    bool n = checkIfValidPosition(LatLng(position.latitude, position.longitude), _area);
    if(n){
      setState(() {
        status = "Available";
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "Error: You are not in your riding region.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //region top status container
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
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
                  children: [
                    Text(
                      "Current Status",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      status != null ? status : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorResources.dodgerBlueColor,
                        fontFamily: FontResources.bold,
                      ),
                    )
                  ],
                ),
              ),
              //endregion
              //region code to start shift
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                    Text(
                      "Shift Setup",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Time",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "20:21 - 22:21",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Area",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Johar Town",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                //region pop up dialog code
                                return StatefulBuilder(
                                  builder: (context, setState){
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 0,
                                      backgroundColor: ColorResources.whiteColor,
                                      child: Form(
                                        key: _formKey,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                //region vehicle type dropdown
                                                Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.0,
                                                        color: ColorResources.smokeWhiteColor,
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                                      color: ColorResources.smokeWhiteColor,
                                                    ),
                                                    child: DropdownButtonFormField<DropdownItem>(
                                                      hint:  textRegular("Select Vehicle", TextAlign.start),
                                                      value: selectedVehicle,
                                                      isExpanded: true,
                                                      onChanged: (DropdownItem? Value) {
                                                        setState(() {
                                                          selectedVehicle = Value!;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: ColorResources.dodgerBlueColor),
                                                          ),
                                                          errorBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: ColorResources.heartColor),
                                                          ),
                                                          errorStyle: TextStyle(
                                                            fontSize: 14,
                                                            color: ColorResources.heartColor,
                                                            fontFamily: FontResources.regular,
                                                          ),
                                                          isDense: false
                                                      ),
                                                      validator: (value) => value == null ? 'Please select vehicle type.' : null,
                                                      onSaved: (value){
                                                        StringResources.vehicleType = value!.name;
                                                      },
                                                      iconSize: 24.0,
                                                      icon: Icon(Icons.keyboard_arrow_down_rounded, size: 24.0, color: ColorResources.darkGreyColor,),
                                                      iconEnabledColor: ColorResources.darkGreyColor,
                                                      iconDisabledColor: ColorResources.darkGreyColor,
                                                      items: vehicle.map((DropdownItem vehicle) {
                                                        return  DropdownMenuItem<DropdownItem>(
                                                          value: vehicle,
                                                          child: Row(
                                                              children: [
                                                                Icon(vehicle.icon, size: 24.0, color: ColorResources.darkGreyColor,),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                textRegular(vehicle.name, TextAlign.start),
                                                              ]
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                                ),
                                                //endregion
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                //region box type dropdown
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 0.0,
                                                      color: ColorResources.smokeWhiteColor,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                                    color: ColorResources.smokeWhiteColor,
                                                  ),
                                                  child: DropdownButtonFormField<DropdownItem>(
                                                    hint:  textRegular("Select Box Type", TextAlign.start),
                                                    value: selectedBox,
                                                    isExpanded: true,
                                                    onChanged: (DropdownItem? Value) {
                                                      setState(() {
                                                        selectedBox = Value!;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(color: ColorResources.dodgerBlueColor),
                                                        ),
                                                        errorBorder: UnderlineInputBorder(
                                                          borderSide: BorderSide(color: ColorResources.heartColor),
                                                        ),
                                                        errorStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorResources.heartColor,
                                                          fontFamily: FontResources.regular,
                                                        ),
                                                        isDense: false
                                                    ),
                                                    validator: (value) => value == null ? 'Please select box type.' : null,
                                                    onSaved: (value){
                                                      StringResources.boxType = value!.name;
                                                    },
                                                    iconSize: 24.0,
                                                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 24.0, color: ColorResources.darkGreyColor,),
                                                    iconEnabledColor: ColorResources.darkGreyColor,
                                                    iconDisabledColor: ColorResources.darkGreyColor,
                                                    items: box.map((DropdownItem box) {
                                                      return  DropdownMenuItem<DropdownItem>(
                                                        value: box,
                                                        child: Row(
                                                            children: [
                                                              Icon(box.icon, size: 24.0, color: ColorResources.darkGreyColor,),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              textRegular(box.name, TextAlign.start),
                                                            ]
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                                //endregion
                                                SizedBox(
                                                    height: 20
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Checkbox(
                                                      value: accept,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          accept = value!;
                                                        });
                                                      },
                                                      activeColor: ColorResources.darkGreyColor,
                                                    ),
                                                    textRegular("I accept Privacy Policy", TextAlign.start)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Visibility(
                                                  visible: accept,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: FlatButton(
                                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                                      color: ColorResources.dodgerBlueColor,
                                                      onPressed: (){
                                                        if (_formKey.currentState!.validate()) {
                                                          _formKey.currentState!.save();
                                                          print(StringResources.vehicleType);
                                                          print(StringResources.boxType);
                                                          checkLocation();
                                                          Navigator.of(context).pop();
                                                        }
                                                      },
                                                      child: Text(
                                                          "START",
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
                                    );
                                  }
                                );
                                //endregion
                          });
                        },
                        child: Text(
                            "START",
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
              //endregion
              //region today shift text
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Today's Shifts",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.bold,
                  ),
                ),
              ),
              //endregion
              //region today shift list code
              Container(
                child: FutureBuilder(
                  future: readJson("URL", "shiftData"),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          ShiftModel shiftModel = snapshot.data[index];
                          return shiftWidget(
                              context,
                              shiftModel.shiftStartTime,
                              shiftModel.shiftEndTime,
                              shiftModel.shiftArea
                            );
                        },
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(child: textBold("${snapshot.error}", TextAlign.start));
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
              //endregion
            ],
          ),
        ),
      ),
    );
  }
}
