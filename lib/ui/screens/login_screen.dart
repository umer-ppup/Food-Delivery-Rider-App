import 'package:flutter/material.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/image_resources.dart';
import 'package:food_rider_app/ui/forms/SignInForm.dart';
import 'package:food_rider_app/ui/screens/signup_screen.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: ColorResources.darkGreyColor,
              fontFamily: FontResources.bold,
            ),
          ),
        ),
        backgroundColor: ColorResources.whiteColor,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      SignInForm(),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textRegular("Don't have an account?", TextAlign.center),
                          SizedBox(width: 10),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(ColorResources.dodgerBlueLightColor),
                            ),
                            child: Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorResources.dodgerBlueColor,
                                fontFamily: FontResources.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
