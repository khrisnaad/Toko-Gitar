import 'package:flutter/material.dart';
import 'package:toko_gitar/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar/utils/routes.dart';
import 'package:toko_gitar/utils/theme.dart';

void main() async{
  runApp(
    MaterialApp(
      title: "Toko Gitar",
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    ));
}