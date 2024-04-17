import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_rider_app/models/rider_model.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Storage storage = new Storage();
  Rider? rider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //region read data for profile
    storage.readData().then((value) async {
      if(value != ""){
        setState(() {
          rider = Rider.fromJson(json.decode(value));
        });
      }
      else{
        rider!.id = "123";
        rider!.name = "ABC";
        rider!.email = "sample@email.com";
        rider!.phoneNumber = "Sample phone number";
        rider!.cnicNumber = "Sample CNIC number";
        rider!.licenseNumber = "Sample license number";
        rider!.vehicleNumber = "Sample vehicle number";
        rider!.password = "Sample password";
      }
    });
    //endregion
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRegular('Profile', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            //region profile header
            profileHeaderWidget(),
            //endregion

            SizedBox(height: 20),

            //region profile menu for different values
            profileMenuWidget(
              context,
              StringResources.userName,
              rider!.name != null ? rider!.name : "",
              Icons.person,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userEmail,
              rider!.email != null ? rider!.email : "",
              Icons.email_rounded,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userPhoneNumber,
              rider!.phoneNumber != null ? rider!.phoneNumber : "",
              Icons.phone,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userCNICNumber,
              rider!.cnicNumber != null ? rider!.cnicNumber : "",
              Icons.perm_identity_rounded,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userLicenseNumber,
              rider!.licenseNumber != null ? rider!.licenseNumber : "",
              Icons.credit_card_rounded,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userVehicleNumber,
              rider!.vehicleNumber != null ? rider!.vehicleNumber : "",
              Icons.delivery_dining,
                  () => {},
            )
            //endregion
          ],
        ),
      ),
    );
  }
}
