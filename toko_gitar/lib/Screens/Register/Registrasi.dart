import 'package:flutter/material.dart';
import 'package:toko_gitar/Components/Register/Registrasi/RegistrasiForm.dart';
import 'package:toko_gitar/utils/size_config.dart';

class RegisterScreen extends StatelessWidget{
  static String routeName = "/sign_up";

  @override 
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body : RegisterForm(),
    );
  }
}