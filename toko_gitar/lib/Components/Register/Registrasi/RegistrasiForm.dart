import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar/Api/configApi.dart';
import 'package:toko_gitar/Components/cust_surfix_icon.dart';
import 'package:toko_gitar/Components/default_button_custome_color.dart';
import 'package:toko_gitar/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar/Screens/Register/registrasi.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/utils/size_config.dart';

class RegisterForm extends StatefulWidget{
  @override 
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm>{
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  String? NamaLengkap;
  String? username;
  String? password;
  String? email;
  bool? remember = false;

  
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtNamaLengkap = TextEditingController();
  TextEditingController txtemail = TextEditingController();

  FocusNode focusNode = new FocusNode();

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Form(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUName(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildNamaLengkap(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(10),),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Buat",
          press: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
            prosesRegistrasi( txtUserName.text,txtPassword.text,txtNamaLengkap.text,txtemail.text);
          },
        ),
        SizedBox(
          height: 20,
        ),
         GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: const Text("Sudah Punya Akun? Masuk Sekarang!", style: TextStyle(decoration: TextDecoration.underline),)
              )
        ],
      )
    );
  }

  TextFormField buildUName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Masukkan Username Anda',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/User Icon.svg",) 
      ),
    );
  }

    TextFormField buildNamaLengkap() {
    return TextFormField(
      controller: txtNamaLengkap,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        hintText: 'Masukkan Nama Lengkap',
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
        hintText: 'Masukkan Password Anda',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",) 
      ),
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtemail,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan Email Anda',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const CustomSurffixIcon(
            svgIcon: "assets/icons/Mail.svg",) 
      ),
    );
  }

  void prosesRegistrasi(userName, password, nama, email) async{
    // utilsApps.showDialog(context);

    bool status;
    var msg;
    try {
    response = await dio.post(urlRegister, data: {
      'username' : userName,
      'password' : password,
      'nama' : nama,
      'email' : email,
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
              Navigator.pushNamed(context, LoginScreen.routeName);
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
            desc: 'Gagal Regis Coy => $msg',
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


