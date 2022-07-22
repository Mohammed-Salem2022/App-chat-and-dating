

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/screen/people_screen.dart';
import '../view/screen/setting_screen.dart';

class HomeController extends GetxController with WidgetsBindingObserver{
   RxInt indexScreens=0.obs;
   var myid=FirebaseAuth.instance.currentUser?.uid;
  final tabs=[
    PeopleScreen(),
    Container(),
    SettingScreen()



  ].obs;
   methodstatus(String status){
     FirebaseFirestore.
     instance.collection('users').doc(myid).update({
       'Status':status,
     });
   }
   @override
   void didChangeAppLifecycleState(AppLifecycleState state) {
     if(state == AppLifecycleState.resumed){
       methodstatus('online');

     }else{
       methodstatus('offline');
     }
   }

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  methodstatus('online');

   WidgetsBinding.instance.addObserver(this);
  }

}