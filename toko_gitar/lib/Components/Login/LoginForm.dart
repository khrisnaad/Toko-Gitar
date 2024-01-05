import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar/Api/configAPI.dart';
import 'package:toko_gitar/Components/cust_surfix_icon.dart';
import 'package:toko_gitar/Components/default_button_custome_color.dart';
import 'package:toko_gitar/Screens/Admin/HomeAdminScreens.dart';
import 'package:toko_gitar/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar/Screens/Register/registrasi.dart';
import 'package:toko_gitar/Screens/User/HomeUserScreens.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/utils/size_config.dart';

class SignInForm extends StatefulWidget{

  @override
  _SignInForm createState() => _SignInForm();
}

class _SignInForm extends State<SignInForm>{

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;

  TextEditingController txtUserName = TextEditingController(),
  txtPassword = TextEditingController();

  
  FocusNode focusNode = new FocusNode();
  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context){
    return Form(
      child: Column(children: [
        buildUserName(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPassword(),
        SizedBox(height: getProportionateScreenHeight(30)),
        Row(
          children: [
            Checkbox(
              value: remember,
              onChanged: (value){
                setState(() {
                  remember = value;
                });
              }),
              const Text("Tetap Masuk"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text("Lupa password?", style: TextStyle(decoration: TextDecoration.underline),)
              )
          ],
        ),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Masuk",
          press: () {
            prosesLogin(txtUserName.text, txtPassword.text);
          },
        ),
        SizedBox(
          height: 20,
        ),
         GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text("Belum Punya Akun? Daftar Sekarang!", style: TextStyle(decoration: TextDecoration.underline),)
              )
      ],
      )
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Input Your Username Here',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",) 
      ),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Input Your Password Here',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/User.svg",) 
      ),
    );
  }

  void prosesLogin(userName, password) async{
    // utilsApps.showDialog(context);

    bool status;
    var msg;
    var dataUser;
    try {
    response = await dio.post(urlLogin, data: {
      'username' : userName,
      'password' : password,
      });  

    status = response!.data['sukses'];
    msg = response!.data['msg'];

    if(status){
      print("Berhasil coy");
      // ignore: use_build_context_synchronously
      AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'INFO INFO',
            desc: 'BERHASIL COYY',
            btnOkOnPress: () {
              dataUser = response!.data['data'];
              if(dataUser['role'] == 1){
                Navigator.pushNamed(context, HomeUserScreen.routeName);
                // print("Masukkan ke halaman user");
              }else if (dataUser['role'] == 2){
                Navigator.pushNamed(context, HomeAdminScreens.routeName);
              }else {
                print("Unavailable pages");
              }
              // Navigator.pushNamed(context, LoginScreen.routeName);
            },
            ).show();
      // utilsApps.hideDialog(context);
    } else{
      print("Gagal coy");
      // ignore: use_build_context_synchronously
      AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'INFO INFO',
            desc: 'Gagal Login Coy => $msg',
            btnOkOnPress: () {},
            ).show();
      // utilsApps.hideDialog(context);
    }

    } catch (e) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'INFO INFO',
            desc: 'Terjadi Kesalahan Bre Mon Maap',
            btnOkOnPress: () {},
            ).show();
    }
    
  }
}