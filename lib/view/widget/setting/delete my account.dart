

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';


 Future<dynamic> Delete_my_account(){
   return  Get.defaultDialog(
     title: 'Delete my account'.tr,
     middleText: 'Do you want delete your account'.tr,
     actions: [
       MaterialButton(
           onPressed: (){

           },
         child: Text(
             'No'.tr
         ),


           ),
       MaterialButton(
         onPressed: () async {
           String? delete = FirebaseAuth.instance.currentUser?.email;
           GetStorage().remove('informationUser');
           GetStorage().remove('signGoogle');
           GetStorage().remove('subscrib');
           FirebaseAuth.instance.currentUser?.delete();
           FirebaseFirestore.instance.collection('users').doc(delete).delete();

           Get.offNamed(NamePages.StartScreen);
         },
         child: Text(
             'Yes'.tr
         ),


       )


     ]

   );

 }
