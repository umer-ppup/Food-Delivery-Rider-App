import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/image_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/ui/screens/login_screen.dart';
import 'package:food_rider_app/ui/screens/profile_screen.dart';
import 'package:food_rider_app/util/util.dart';
// import 'package:progress_dialog/progress_dialog.dart';

//region widget for bold text
Widget textBold(String text, TextAlign textAlign){
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 16,
      color: ColorResources.darkGreyColor,
      fontFamily: FontResources.bold,
    ),
  );
}
//endregion

//region widget for regular text
Widget textRegular(String text, TextAlign textAlign){
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 16,
      color: ColorResources.darkGreyColor,
      fontFamily: FontResources.regular,
    ),
  );
}
//endregion

//region class for button
class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final String text;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ColorResources.darkGreyColor,
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.whiteColor,
            fontFamily: FontResources.bold,
          )
        ),
      ),
    );
  }
}
//endregion

//region a widget class to show OR with divider line
class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: ColorResources.darkGreyColor,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: ColorResources.darkGreyColor,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
//endregion

//region this is a widget class to show social platform icons
class SocialCardWidget extends StatelessWidget {
  const SocialCardWidget({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(12.0),
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: ColorResources.smokeWhiteColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
//endregion

//region this is a widget for input field for forms
Widget inputField(FocusNode focusNode, TextEditingController tController, TextInputAction action, TextInputType textType, String label, IconData icon, String validatorTxt, TextEditingController tControllerPassword, BuildContext context,
    FocusNode nameFocusNode, FocusNode emailFocusNode, FocusNode phoneNumberFocusNode, FocusNode cnicNumberFocusNode, FocusNode licenseNumberFocusNode, FocusNode vehicleNumberFocusNode, FocusNode passwordFocusNode, FocusNode cPasswordFocusNode, String hint){
  return TextFormField(
    focusNode: focusNode,
    controller: tController,
    textInputAction: action,
    autofocus: false,
    keyboardType: textType,
    obscureText: validatorTxt == 'password' || validatorTxt == 're-enter' ? true : false,
    style: TextStyle(
      fontSize: 16,
      color: ColorResources.darkGreyColor,
      fontFamily: FontResources.regular,
    ),
    cursorColor: ColorResources.darkGreyColor,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorResources.darkGreyColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorResources.darkGreyColor,
        ),
      ),
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
      alignLabelWithHint: true,
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 16,
        color: ColorResources.lightGreyColor,
        fontFamily: FontResources.regular,
      ),
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 16,
        color: ColorResources.darkGreyColor,
        fontFamily: FontResources.regular,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: Icon(icon, color: ColorResources.darkGreyColor,),
    ),
    validator: (value){
      if(validatorTxt == 'name'){
        if (value!.isEmpty) {
          return 'Please enter your name.';
        }
        else {
          return null;
        }
      }
      else if(validatorTxt == 'email'){
        if (value!.isEmpty) {
          return 'Please enter an email address.';
        } else if (!StringResources.kEmailValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid email address.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'phone_number'){
        if (value!.isEmpty) {
          return 'Please enter your phone number.';
        } else if (!StringResources.kPhoneValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid phone number.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'cnic_number'){
        if (value!.isEmpty) {
          return 'Please enter your cnic number.';
        } else if (!StringResources.kcnicValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid cnic number.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'license_number'){
        if (value!.isEmpty) {
          return 'Please enter your license number.';
        } else if (!StringResources.klicenseValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid license number.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'vehicle_number'){
        if (value!.isEmpty) {
          return 'Please enter your vehicle number.';
        } else if (!StringResources.kvehicleValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid vehicle number.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'password'){
        if(value!.isEmpty)
        {
          return 'Please enter password.';
        }
        else if (value.length < 8)
        {
          return 'Password cannot less than 8 characters.';
        }
        else
        {
          return null;
        }
      }
      else if(validatorTxt == 're-enter'){
        if(value!.isEmpty)
        {
          return 'Please enter password.';
        }
        else if (tControllerPassword.text != tController.text)
        {
          return 'Please enter same password.';
        }
        else
        {
          return null;
        }
      }
      else{
        return null;
      }
    },
    onSaved: (value){
      if(validatorTxt == 'name'){
        StringResources.name = value!;
      }
      else if(validatorTxt == 'email'){
        StringResources.email = value!;
      }
      else if(validatorTxt == 'phone_number'){
        StringResources.phoneNumber = value!;
      }
      else if(validatorTxt == 'cnic_number'){
        StringResources.cnicNumber = value!;
      }
      else if(validatorTxt == 'license_number'){
        StringResources.licenseNumber = value!;
      }
      else if(validatorTxt == 'vehicle_number'){
        StringResources.vehicleNumber = value!;
      }
      else if(validatorTxt == 'password'){
        StringResources.password = value!;
      }
      else if(validatorTxt == 're-enter'){
        StringResources.confirmPassword = value!;
      }
    },
    onFieldSubmitted: (_){
      if(validatorTxt == 'name'){
        fieldFocusChange(context, nameFocusNode, emailFocusNode);
      }
      else if(validatorTxt == 'email'){
        fieldFocusChange(context, emailFocusNode, phoneNumberFocusNode);
      }
      else if(validatorTxt == 'phone_number'){
        fieldFocusChange(context, phoneNumberFocusNode, cnicNumberFocusNode);
      }
      else if(validatorTxt == 'cnic_number'){
        fieldFocusChange(context, cnicNumberFocusNode, licenseNumberFocusNode);
      }
      else if(validatorTxt == 'license_number'){
        fieldFocusChange(context, licenseNumberFocusNode, vehicleNumberFocusNode);
      }
      else if(validatorTxt == 'vehicle_number'){
        fieldFocusChange(context, vehicleNumberFocusNode, passwordFocusNode);
      }
      else if(validatorTxt == 'password'){
        fieldFocusChange(context, passwordFocusNode, cPasswordFocusNode);
      }
    },
  );
}
//endregion

//region this is a widget for profile header
Widget profileHeaderWidget() {
  return Container(
    height: 150.0,
    width: 150.0,
    child: Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(ImageResources.profile),
        ),
        Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 60,
              width: 60,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: ColorResources.whiteColor, width: 5.0),
                ),
                color: ColorResources.smokeWhiteColor,
                child: SvgPicture.asset(ImageResources.camera, color: ColorResources.darkGreyColor),
                onPressed: () {},
              ),
            ))
      ],
    ),
  );
}
//endregion

//region this is a widget for profile menu
Widget profileMenuWidget(BuildContext context, String text, String textValue, IconData icon, VoidCallback press) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.0,
        color: ColorResources.smokeWhiteColor,
      ),
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
      color: ColorResources.smokeWhiteColor,
    ),
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Row(
      children: [
        Icon(
          icon,
          size: 32.0,
          color: ColorResources.darkGreyColor,
        ),
        SizedBox(width: 20),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    textValue,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  )
                ]
            )
        )
      ],
    ),
  );

}
//endregion

//region this is a widget for navigation drawer
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: Container(
          color: ColorResources.whiteColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              createDrawerHeader(),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.person, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Profile',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              Divider(
                color: ColorResources.darkGreyColor,
                //height: 20,
                thickness: 0.2,
                indent: 0,
                endIndent: 0,
              ),
              InkWell(
                onTap: () async {
                  // change app state...
                  // await pr.show();
                  await addBoolToSF('login', false);
                  // await pr.hide();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen())); // close the drawer
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Logout',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//endregion

//region this is a widget for navigation drawer header
Widget createDrawerHeader() {
  return Container(
    color: ColorResources.whiteColor,
    child: DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: CircleAvatar(
              radius: 55.0,
              backgroundColor: ColorResources.smokeWhiteColor,
              child: Image.asset(
                "asset/images/atrule_icon.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: textBold('ATRULE Technologies', TextAlign.start),
          ),
        ],
      ),
    ),
  );
}
//endregion

//region widget for order history list
Widget orderHistoryWidget(BuildContext context, String type, String orderNumber, String time){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.0,
        color: ColorResources.smokeWhiteColor,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(7.0)),
      color: ColorResources.smokeWhiteColor,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          type == "1" ? Icons.attach_money_rounded: Icons.credit_card,
          color: ColorResources.dodgerBlueColor,
          size: 32.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        textRegular(orderNumber != null ? orderNumber : "OrderId", TextAlign.start),
        Spacer(),
        textRegular(time != null ? time : "Time", TextAlign.start),
      ],
    ),
  );
}
//endregion

//region widget for list of transactions in wallet tab
Widget walletWidget(BuildContext context, String id, String date, String time, String amount){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.0,
        color: ColorResources.smokeWhiteColor,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(7.0)),
      color: ColorResources.smokeWhiteColor,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: ColorResources.darkGreyColor,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  textRegular(id != null ? id : "TransactionId", TextAlign.start),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: ColorResources.darkGreyColor,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  textRegular(date != null ? date : "TransactionDate", TextAlign.start),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: ColorResources.darkGreyColor,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  textRegular(time != null ? time : "TransactionTime", TextAlign.start)
                ],
              )
            ],
          ),
        ),
        Text(
          amount != null ? "$amount Rs." : "",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.dodgerBlueColor,
            fontFamily: FontResources.regular,
          ),
        )
      ],
    ),
  );
}
//endregion

//region widget for today shift list
Widget shiftWidget(BuildContext context, String startTime, String endTime, String area){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.0,
        color: ColorResources.smokeWhiteColor,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(7.0)),
      color: ColorResources.smokeWhiteColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textBold("$startTime - $endTime", TextAlign.start),
        SizedBox(
          height: 10.0,
        ),
        textRegular(area, TextAlign.start),
      ],
    ),
  );
}
//endregion

//region Widget for list of confirm order items before pickup
Widget orderItemWidget(BuildContext context, String itemName, String itemQuantity){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.0,
        color: ColorResources.smokeWhiteColor,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(7.0)),
      color: ColorResources.smokeWhiteColor,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textRegular(itemName != null ? itemName : "Item Name", TextAlign.start),
        Spacer(),
        textRegular(itemQuantity != null ? itemQuantity : "Item Quantity", TextAlign.start),
      ],
    ),
  );
}
//endregion