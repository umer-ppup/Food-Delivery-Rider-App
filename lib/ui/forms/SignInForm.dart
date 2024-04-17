import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_rider_app/models/rider_model.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/ui/screens/forgot_password_screen.dart';
import 'package:food_rider_app/ui/screens/home/home_screen.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInForm extends StatefulWidget {
  Storage storage = new Storage();
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  //TextController to read text entered in text field
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

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
      child: Column(
        children: [
          inputField(_emailFocusNode, cEmail, TextInputAction.next, TextInputType.emailAddress, StringResources.userEmail, Icons.email_rounded,
              'email', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
          , ""),
          SizedBox(height: 30),
          inputField(_passwordFocusNode, cPassword, TextInputAction.done, TextInputType.text, StringResources.userPassword, Icons.vpn_key_rounded,
              'password', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _cnicNumberFocusNode, _licenseNumberFocusNode, _vehicleNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode
          , ""),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(ColorResources.heartLightColor),
                ),
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.heartColor,
                    fontFamily: FontResources.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          DefaultButton(
            text: 'Login',
            onPress: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // await pr.show();
                widget.storage.readData().then((value) async {
                  if(value != ""){
                    Rider rider = Rider.fromJson(json.decode(value));
                    if(rider.email == StringResources.email && rider.password == StringResources.password){
                      addBoolToSF('login', true);
                      // await pr.hide();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                    }
                    else{
                      // await pr.hide();
                      Fluttertoast.showToast(
                          msg: "Error: Login failed.",
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
                    // await pr.hide();
                    Fluttertoast.showToast(
                        msg: "Error: Login failed.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorResources.heartColor,
                        textColor: ColorResources.whiteColor,
                        fontSize: 16.0
                    );
                  }
                });
                // Login login = new Login(email: StringResources.email, password: StringResources.password);
                // loginPostRequest('CREATE_loginPost_URL', body: login.toJson()).then((value){
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
