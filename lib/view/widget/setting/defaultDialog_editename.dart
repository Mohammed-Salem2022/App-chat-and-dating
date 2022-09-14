


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme.dart';



final keyform=GlobalKey<FormState>();
Future<dynamic> defaultDialogEditName(){
  TextEditingController textEditingdefaultDialogName=TextEditingController();
  return  Get.defaultDialog(


    title: 'Edite your name'.tr,
    content:  Form(
      key:  keyform ,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFailddefaultDialog(
                suffixIcon:   IconButton(
                    onPressed: (){
                      textEditingdefaultDialogName.clear();
                    },
                    icon:  const Icon(Icons.close,color: Colors.black,)
                ),
                controller1: textEditingdefaultDialogName,
                obscureText1: false,
                textInputType: TextInputType.text,
                validator:  (value){
                  if(textEditingdefaultDialogName.text.isEmpty  ){
                    return 'Edite your name'.tr;
                  }

                  if(value.length<=3){
                    return 'Your name must be more than 3 letters'.tr;
                  }
                },

                label: Text('Edite your name'.tr),
                maxLength: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Text(
                      'Ok',
                      style:TextStyle(
                          color:Get.isDarkMode?pinkClr: mainColor,

                      ),

                  ),
                  onTap: (){
                    String? email= FirebaseAuth.instance.currentUser!.email;
                    if(keyform.currentState!.validate()){

                       FirebaseFirestore.instance.collection('users').doc(email).
                       update({'name':textEditingdefaultDialogName.text});
                        Get.back();
                    }
                  },
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Text('cancel',style:TextStyle(
                      color:Get.isDarkMode?pinkClr: mainColor
                  )
                  ),
                ),
              ],
            )
          ],
        )
    ),

  );
}
class TextFailddefaultDialog extends StatelessWidget{

  final  TextEditingController? controller1;
  final  bool obscureText1;
  final  TextInputType textInputType;
  final  Function validator;
 final   Widget suffixIcon;
  final  Widget label;
  final  int maxLength;
  TextFailddefaultDialog({Key? key,required this.controller1,
    required this.obscureText1,
    required this.textInputType,
    required this.validator,
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

      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color:mainColor,width: 3 ),
        ),
        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color:mainColor,width: 3 ),),
      ),

    );
  }




}