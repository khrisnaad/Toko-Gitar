
import 'package:flutter/material.dart';
import 'package:toko_gitar/Screens/Admin/Crud/InputGitarScreen.dart';
import 'package:toko_gitar/Screens/Admin/HomeAdminScreens.dart';
import 'package:toko_gitar/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar/Screens/Register/registrasi.dart';
import 'package:toko_gitar/Screens/User/HomeUserScreens.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),

  //routes user biasa
  HomeUserScreen.routeName: (context) => HomeUserScreen(),

  // routes admin
  HomeAdminScreens.routeName: (context) => HomeAdminScreens(),
  InputGitarScreen.routeName: (context) => InputGitarScreen(),
};