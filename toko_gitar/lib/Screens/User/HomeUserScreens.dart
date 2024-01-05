import 'package:flutter/material.dart';
import 'package:toko_gitar/utils/size_config.dart';

class HomeUserScreen extends StatelessWidget{
  static String routeName = "/Home_user";

  @override 
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body : Container(child: Text("Selamat datang di toko gitar"),),
    );
  }
}