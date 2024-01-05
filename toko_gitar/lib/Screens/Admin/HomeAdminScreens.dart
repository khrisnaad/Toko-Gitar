import 'package:flutter/material.dart';
import 'package:toko_gitar/Screens/Admin/Crud/InputGitarScreen.dart';
import 'package:toko_gitar/utils/constants.dart';

class HomeAdminScreens extends StatelessWidget {
  static var routeName = '/home_admin_screens';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Gitar Bagus", 
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.home, color: mTitleColor
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, InputGitarScreen.routeName);
            },
            child: const Row(children: [
              Icon(Icons.add, color: mTitleColor), 
              Text("Input Data", style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
            ],),
          ),
          const SizedBox(
            width: 10,
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kColorRedSlow,
        child: Icon(
          Icons.logout,
          color: Colors.white,
          ),
      ),
    );
  }
}