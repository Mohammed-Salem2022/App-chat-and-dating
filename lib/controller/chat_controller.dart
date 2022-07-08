

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/send_information_user.dart';
import '../model/send_talk_to_chat.dart';

class ChatController extends GetxController{
 var myid=FirebaseAuth.instance.currentUser?.uid;
 CollectionReference collectionReference= FirebaseFirestore.instance.collection('users');
 CollectionReference collectionReferenceChat= FirebaseFirestore.instance.collection('Chats');
 Rx<TextEditingController> textMessage= TextEditingController().obs;
 bool textbool=true;



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

   }).then((value) => {


   }

   );


 }
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();


  }

}