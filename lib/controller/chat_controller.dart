

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import '../model/send_information_user.dart';
import '../model/send_talk_to_chat.dart';

class ChatController extends GetxController {
 var myid=FirebaseAuth.instance.currentUser?.uid;
 CollectionReference collectionReference= FirebaseFirestore.instance.collection('users');
 CollectionReference collectionReferenceChat= FirebaseFirestore.instance.collection('Chats');
 Rx<TextEditingController> textMessage= TextEditingController().obs;
 bool textbool=true;
 bool mytext=false;



 sendMessageToChat(SendMessageToChat sendMessageToChat){
   //هنا نرسل البيانات الى فايربيس
   CollectionReference userRef=FirebaseFirestore.instance.collection('Chats');
   userRef.add({
     'myid':           sendMessageToChat.myid,
     'name':           sendMessageToChat.name,
     'message':           sendMessageToChat.message,
     'imageProfile':   sendMessageToChat.imageprofile,
     'randomNumber':   sendMessageToChat.randomNumber,
     'time':           FieldValue.serverTimestamp(),
     'isRead':           'false',


   }).then((value) => {


   }

   );


 }

 String date(Timestamp date){
   //هنا التاريخ

   final Timestamp timestamp =date;
   final DateTime dateTime =timestamp.toDate();
   final dateString =DateFormat('EEEE').format(dateTime);

   return dateString;
 }
 String time(Timestamp date){
   //هنا الوقت
   var dataformat=DateTime.fromMillisecondsSinceEpoch(date.seconds*1000);
   return  DateFormat('hh:mm').format(dataformat);

 }
 readMessageOrNot(String isRead)async{
   // FirebaseFirestore.instance.collection('Chats').get().then((snapshot) {
   //   for (DocumentSnapshot ds in snapshot.docs) {
   //     ds.reference.update({
   //       'isRead': isRead,//True or false
   //
   //     });
   //   }
   // });
   FirebaseFirestore.instance.collection('Chats').orderBy('time').limitToLast(2).get().then((snapshot) {
     for (DocumentSnapshot ds in snapshot.docs) {
           ds.reference.update({
             'isRead': isRead,//True or false

           });
         }

   });
    
 }
 void deleteAlldecomtion()async{
   FirebaseFirestore.instance.collection('Chats').orderBy('time').get().then((snapshot) {

     for(int i=0 ;i<15;++i){
      snapshot.docs[i].reference..delete();

     }

   });
 }
 void updateHours() async{


 }
//  @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   if(state == AppLifecycleState.resumed){
//     readMessageOrNot('true');
//
//   }else{
//
//   }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   readMessageOrNot('true');
    updateHours();
    // WidgetsBinding.instance.addObserver(this);
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  //  readMessageOrNot('true');


  }
  @override
  void onClose() {
    // TODO: implement onClose


    super.onClose();

  }
}