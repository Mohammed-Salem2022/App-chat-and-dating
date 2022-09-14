

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main.dart';
import '../model/notification_api.dart';
import '../view/screen/people_screen.dart';
import '../view/screen/setting_screen.dart';
import 'chat_controller.dart';

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
     //هنا يقلك هل انا فاتح التطبيق او لا
     if(state == AppLifecycleState.resumed){
       methodstatus('online');




     }else{
       methodstatus('offline');
       if( GetStorage().read('subscrib')==true){

         FirebaseMessaging.instance.subscribeToTopic('groupchat');
         FirebaseMessaging.onMessage.listen((  message) {
           LocalNotificationService.showNotificationMediaStyle(message);

         });

       }




     }



   }

   @override
  void onInit()async {
    // TODO: implement onInit

    super.onInit();
    methodstatus('online');
    WidgetsBinding.instance.addObserver(this);
    // String? email = FirebaseAuth.instance.currentUser?.email;
    // FirebaseFirestore.instance.collection('users').doc(email).update({'time':FieldValue.serverTimestamp()});




  }
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    LocalNotificationService. notificationPermission();




  }
}