import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_rider_app/models/rider_model.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpForm extends StatefulWidget {
  Storage storage = new Storage();
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();


  //TextController to read text entered in text field
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController cLicenseNumber = TextEditingController();
  TextEditingController cCNIC = TextEditingController();
  TextEditingController cVehicleNumber = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cConfirmPassword = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _licenseNumberFocusNode = FocusNode();
  FocusNode _cnicNumberFocusNode = FocusNode();
  FocusNode _vehicleNumberFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Form(
      key: _formKey,
      //autovalidate: true,
      child: Column(
        children: [
          SizedBox(height: 30),
          inputField(_nameFocusNode, cName, TextInputAction.next, TextInputType.name, StringResources.userName, Icons.person,
              'name', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
          , ""),
          SizedBox(height: 30),
          inputField(_emailFocusNode, cEmail, TextInputAction.next, TextInputType.emailAddress, StringResources.userEmail, Icons.email_rounded,
              'email', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
          , ""),
          SizedBox(height: 30),
          inputField(_phoneNumberFocusNode, cPhoneNumber, TextInputAction.next, TextInputType.phone, StringResources.userPhoneNumber, Icons.phone,
              'phone_number', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , ""),
          SizedBox(height: 30),
          inputField(_cnicNumberFocusNode, cCNIC, TextInputAction.next, TextInputType.number, StringResources.userCNICNumber, Icons.perm_identity_rounded,
              'cnic_number', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , "12345-12345678-1"),
          SizedBox(height: 30),
          inputField(_licenseNumberFocusNode, cLicenseNumber, TextInputAction.next, TextInputType.text, StringResources.userLicenseNumber, Icons.credit_card_rounded,
              'license_number', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , "AA12BB1234"),
          SizedBox(height: 30),
          inputField(_vehicleNumberFocusNode, cVehicleNumber, TextInputAction.next, TextInputType.text, StringResources.userVehicleNumber, Icons.delivery_dining,
              'vehicle_number', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , "ABC1234"),
          SizedBox(height: 30),
          inputField(_passwordFocusNode, cPassword, TextInputAction.done, TextInputType.text, StringResources.userPassword, Icons.vpn_key_rounded,
              'password', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , ""),
          SizedBox(height: 30),
          inputField(_confirmPasswordFocusNode, cConfirmPassword, TextInputAction.done, TextInputType.text, StringResources.userConfirmPassword, Icons.vpn_key_rounded,
              're-enter', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
              , ""),
          SizedBox(height: 50),
          DefaultButton(
            text: 'Sign Up',
            onPress: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // await pr.show();
                widget.storage.readData().then((value) async {
                  if(value != ""){
                    Rider rider = Rider.fromJson(json.decode(value));
                    if(rider.email != StringResources.email){
                      Rider rider = new Rider(
                          id: "user101",
                          name: StringResources.name,
                          email: StringResources.email,
                          phoneNumber: StringResources.phoneNumber,
                          cnicNumber: StringResources.cnicNumber,
                          licenseNumber: StringResources.licenseNumber,
                          vehicleNumber: StringResources.vehicleNumber,
                          password: StringResources.password
                      );
                      await widget.storage.writeData(json.encode(rider));
                      addBoolToSF('login', true);
                      // await pr.hide();
                      Navigator.of(context).pop();
                    }
                    else{
                      // await pr.hide();
                      Fluttertoast.showToast(
                          msg: "Error: Email already exists.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorResources.heartColor,
                          textColor: ColorResources.whiteColor,
                          fontSize: 16.0
                      );
                    }
                  }
                  else{
                    Rider rider = new Rider(
                        id: "user101",
                        name: StringResources.name,
                        email: StringResources.email,
                        phoneNumber: StringResources.phoneNumber,
                        cnicNumber: StringResources.cnicNumber,
                        licenseNumber: StringResources.licenseNumber,
                        vehicleNumber: StringResources.vehicleNumber,
                        password: StringResources.password
                    );
                    await widget.storage.writeData(json.encode(rider));
                    addBoolToSF('login', true);
                    // await pr.hide();
                    Navigator.of(context).pop();
                  }
                });

                // User user = new User(name: StringResources.name, email: StringResources.email, phoneNumber: StringResources.phoneNumber, password: StringResources.password);
                // signUpPostRequest('CREATE_signUpPost_URL', body: user.toJson()).then((value){
                //   pr.hide();
                // });
              }
            },
          )
        ],
      ),
    );
  }
}
