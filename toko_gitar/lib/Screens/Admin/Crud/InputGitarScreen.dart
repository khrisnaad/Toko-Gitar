import 'package:flutter/material.dart';
import 'package:toko_gitar/Components/Admin/Crud/InputGitar/InputGitarComponent.dart';
import 'package:toko_gitar/utils/constants.dart';

class InputGitarScreen extends StatelessWidget {
  static var routeName = '/input_gitar_screens';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Input Data Gitar Mu Disini", style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),),
      ),
      body: InputGitarComponent(),
    );
  }
}