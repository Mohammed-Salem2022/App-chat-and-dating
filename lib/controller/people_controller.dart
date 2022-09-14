
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/notification_api.dart';
class PeopleController extends GetxController{
 User?user= FirebaseAuth.instance.currentUser;

 bool subscribe=true;
   void subscribeunsubscribe(){
     subscribe=!subscribe;
     update();
   }

   Stream<QuerySnapshot<Object?>>  getdataUser(){
     CollectionReference  re= FirebaseFirestore.instance.collection('users');
    return  re.orderBy('time').snapshots() ;


  }


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

   
    if( GetStorage().read('subscrib') ==null || GetStorage().read('subscrib')==true){

      FirebaseMessaging.instance.subscribeToTopic('groupchat');
      FirebaseMessaging.onMessage.listen((  message) {
        LocalNotificationService.showNotificationMediaStyle(message);

      });

    }




  }
   @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }
}