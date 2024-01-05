import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toko_gitar/Api/configAPI.dart';
import 'package:toko_gitar/Components/cust_surfix_icon.dart';
import 'package:toko_gitar/Components/default_button_custome_color.dart';
import 'package:toko_gitar/Screens/Admin/HomeAdminScreens.dart';
import 'package:toko_gitar/Screens/Login/LoginScreens.dart';
import 'package:toko_gitar/Screens/Register/registrasi.dart';
import 'package:toko_gitar/Screens/User/HomeUserScreens.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';

class FormInputGitar extends StatefulWidget{

  @override
  _FormInputGitar createState() => _FormInputGitar();
}

class _FormInputGitar extends State<FormInputGitar>{


  TextEditingController txtNamaGitar = TextEditingController(),
  txtTipeGitar = TextEditingController(),
  txtHargaGitar = TextEditingController(),
  txtMerekGitar = TextEditingController();

  
  FocusNode focusNode = new FocusNode();
  File? image;
  Response? response;
  var dio = Dio();

  @override
  Widget build(BuildContext context){
    return Form(
      child: Column(children: [
        buildNamaGitar(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildTipeGitar(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildHargaGitar(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildMerekGitar(),
        SizedBox(height: getProportionateScreenHeight(30)),
        image == null ? Container():Image.file(image!, width: 250, height: 250, fit: BoxFit.cover,),        
        SizedBox(height: getProportionateScreenHeight(30)),
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "Pilih Gambar Gitar",
          press: () {
            pilihGambar();
          },
        ),
        SizedBox(height: getProportionateScreenHeight(30)),        
        DefaultButtonCustomeColor(
          color: kPrimaryColor,
          text: "SUBMIT",
          press: () {
            inputDataGitar(txtNamaGitar.text, txtTipeGitar.text, txtHargaGitar.text, txtMerekGitar.text, image?.path);  
            },
        ),
        SizedBox(
          height: 20,
        ),
        ],
      )
    );
  }

  TextFormField buildNamaGitar() {
    return TextFormField(
      controller: txtNamaGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Nama Gitar',
        hintText: 'Masukkan Nama Gitar',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.post_add_rounded) 
      ),
    );
  }

  TextFormField buildTipeGitar() {
    return TextFormField(
      controller: txtTipeGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Tipe Gitar',
        hintText: 'Masukkan Tipe Gitar',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.post_add_rounded) 
      ),
    );
  }
  TextFormField buildHargaGitar() {
    return TextFormField(
      controller: txtHargaGitar,
      keyboardType: TextInputType.number,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Harga Gitar',
        hintText: 'Masukkan Harga Gitar',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.add_rounded) 
      ),
    );
  }

  TextFormField buildMerekGitar() {
    return TextFormField(
      controller: txtMerekGitar,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Merek Gitar',
        hintText: 'Masukkan Merek Gitar',
        labelStyle: TextStyle(
          color : focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.post_add_rounded) 
      ),
    );
  }

  Future pilihGambar() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(()=> this.image = imageTemp);
    }  on PlatformException catch (e) {
      print("Gagal mengambil gambar : $e");
    }
  }

  void inputDataGitar (nama, tipe, harga, merk, gambar) async{
    bool status;
    var msg; 
    try {
      var formData = FormData.fromMap({
        'nama' : nama,
        'tipe' : tipe,
        'harga' : harga,
        'merk' : merk,
        'gambar' : await MultipartFile.fromFile(gambar)
      });

      response = await dio.post(inputGitar, data : formData);
      status = response!.data['sukses'];
      msg = response!.data ['msg'];
      if(status){
        AwesomeDialog(context: context, 
        dialogType: DialogType.success, 
        animType: AnimType.rightSlide, 
        title: 'Peringatan', 
        desc: '$msg',
        btnOkOnPress: () {
          Navigator.pushNamed(context, HomeAdminScreens.routeName);
        }).show();
      }else {
        AwesomeDialog(context: context, 
        dialogType: DialogType.success, 
        animType: AnimType.rightSlide, 
        title: 'Peringatan', 
        desc: '$msg',
        btnOkOnPress: () {}
        ).show();
      }
    } catch (e) {
        AwesomeDialog(context: context, 
        dialogType: DialogType.success, 
        animType: AnimType.rightSlide, 
        title: 'Peringatan', 
        desc: 'Terjadi Kesalahan',
        btnOkOnPress: () {}
        ).show();
    }
  }
}