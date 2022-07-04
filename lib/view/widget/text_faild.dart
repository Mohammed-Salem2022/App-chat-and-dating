

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
class TextFaild extends StatelessWidget{

  final  TextEditingController? controller1;
  final  bool obscureText1;
  final  TextInputType textInputType;
  final  Function validator;
  final  Widget? suffixIcon;
  final  Widget prefixIcon;
  final  Widget label;
  final  int maxLength;
  TextFaild(
      {
     Key? key,
     required this.controller1,
    required this.obscureText1,
    required this.textInputType,
    required this.validator,
    required this.prefixIcon,
    required this.suffixIcon,
    required this.label,
    required this.maxLength,

  })

      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return     TextFormField(
      controller: controller1,

      validator: (value)=> validator(value),
      obscureText:obscureText1 ,
      cursorColor: darkGreyClr,
      keyboardType: textInputType,
      maxLength: maxLength,


      decoration:  InputDecoration(
          errorStyle: TextStyle(color: Get.isDarkMode  ? Colors.red:Colors.red ,fontWeight: FontWeight.bold),
          label: label,
         // fillColor: Colors.grey.shade200,
         filled: true,
          labelStyle: TextStyle(fontSize: 20,color:Get.isDarkMode  ? Colors.white:Colors.black ,fontWeight: FontWeight.bold),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,


          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Get.isDarkMode?pinkClr:Colors.blueAccent,width: 3 ),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:Get.isDarkMode?pinkClr:Colors.blueAccent,width: 3 ),),

          ),



    );
  }




}