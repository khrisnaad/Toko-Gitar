import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:toko_gitar/Components/Login/LoginForm.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/utils/size_config.dart';

class LoginComponent extends StatefulWidget {
  @override
  _LoginComponent createState() => _LoginComponent();
}

class _LoginComponent extends State<LoginComponent>{
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.08,
                    ),
                    SimpleShadow(
                      child : Image.asset("assets/images/icon.png", 
                      height: 150, 
                      width: 202,
                      ),
                      opacity : 0.5,
                      color: kSecondaryColor,
                      offset: Offset(5, 5),
                      sigma: 2,
                    ),
                    Padding(padding: EdgeInsets.only(left:10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login!",
                          style: mTitleStyle,
                        )
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    SignInForm()
              ],
              ),
            ),
            ),
      ) 
    );
  } 
}