

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import '../model/notification_api.dart';
import '../model/send_information_user.dart';
import '../model/send_talk_to_chat.dart';
import '../model/sendnotifaction.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../routes/routes.dart';
class ChatController extends GetxController {
  var myid = FirebaseAuth.instance.currentUser?.uid;
  var email = FirebaseAuth.instance.currentUser?.email;
   List list=['now','1m','2m','3m','4m','5m','6m','7m','8m','9m','10m','11m','12m','13m','14m','15m','16m','17m','18m','19m','20m','21m','22m','23m','24m','25m','26m','27m','28m','29m','30m','31m','32m','33m','34m','35m','36m','37m','38m','39m','40m','41m','42m','43m','44m','45m','46m','47m','48m','49m','50m','51m','52m','53m','54m','55m','56m','57m','58m','59m','~1h','2h',];
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  CollectionReference collectionReferenceChat = FirebaseFirestore.instance
      .collection('Chats');
  Rx<TextEditingController> textMessage = TextEditingController().obs;
  bool textbool = true;
  bool mytext = false;
  bool deliveredbool = true;
  String? nameReport;

  bool gettimeago(String timeago){
    //هنا حتى نجيب الوقت بدقايق مثال 4m or 5m or h1
    for(var f in list){
      if(f==timeago){
        return true;
      }

    }
    return false;
  }
  sendMessageToChat(SendMessageToChat sendMessageToChat) {
    //هنا نرسل البيانات الى فايربيس

    DocumentReference userRef = FirebaseFirestore.instance.collection('Chats').doc();
    userRef.set({
      'email': email,
      'name': sendMessageToChat.name,
      'message': sendMessageToChat.message,
      'imageProfile': sendMessageToChat.imageprofile,
      'randomNumber': sendMessageToChat.randomNumber,
      'time': FieldValue.serverTimestamp(),
      'isRead': 'false',
      'decomtionid': '1',
      'isDelete': userRef.id,


    }).then((value) =>
      sendnotifiction(sendMessageToChat.name!,sendMessageToChat.message!,sendMessageToChat.imageprofile!)

    ).catchError((onError) {

    });
  }

  String date(Timestamp date) {
    //هنا التاريخ

    final Timestamp timestamp = date;
    final DateTime dateTime = timestamp.toDate();
    final dateString = DateFormat('EEEE').format(dateTime);

    return dateString;
  }

  String time(Timestamp date) {
    //هنا الوقت
    var dataformat = DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000);
    return DateFormat('hh:mm').format(dataformat);
  }

  void sendMessageOrNot() async {
    //هل رسالة وصلت الى فايربيس لا

  CollectionReference collectionReference= FirebaseFirestore.instance.collection('Chats');
  collectionReference.limit(5).orderBy('time',descending:  true).get().then((value) {
    for (DocumentSnapshot ds in value.docs) {
          ds.reference.update({
            'decomtionid': '1',//True or false

          });
        }

  });

  }


  readMessageOrNot(String isRead) async {
    FirebaseFirestore.instance.collection('Chats').orderBy('time', descending:  true)

        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.update({
          'isRead': isRead, //True or false

        });
      }
    });
  }

  void deleteAlldecomtion() async {
    FirebaseFirestore.instance.collection('Chats').orderBy('time').get().then((
        snapshot) {
      for (int i = 0; i < 15; ++i) {
        snapshot.docs[i].reference..delete();
      }
    });
  }
  void deleteMydecomtiononly(String decomtion ) async {
    // Here delete My text Only
     CollectionReference     userRef= FirebaseFirestore.instance.collection('Chats');
     userRef.doc(decomtion).delete();

  }
  void reportUser({
    required String idImReport ,
    required String idUser,
    required String nameuser,
    required String message
  }) async {
    // Here report other text

   await FirebaseFirestore.instance.collection('users').doc(email).get().then((value) {

   nameReport=  value.data()!['name'];

   });

     DocumentReference      userRef= FirebaseFirestore.instance.collection('report').doc(email).collection('users2').doc();
    await userRef.set({
      'idImReport': idImReport,
      'nameReport': nameReport,
      'idUser': idUser,
      'nameuser': nameuser,
      'message': message,
      'time': FieldValue.serverTimestamp(),



    });

  }
   String datelist(Timestamp date){

     final Timestamp timestamp = date;
     final DateTime dateTime = timestamp.toDate();
     final dateString = DateFormat('dd EE').format(dateTime);


     return dateString;


   }

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();

    FirebaseMessaging.instance.unsubscribeFromTopic('groupchat');


  }

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await LocalNotificationService. flutterLocalNotificationsPlugin2.cancelAll();
  }
@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    if( GetStorage().read('subscrib')==true ||  GetStorage().read('subscrib') ==null){

    FirebaseMessaging.instance.subscribeToTopic('groupchat');
    }
  }

}

class ChatControllerBindings extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut(() => ChatController());

  }



}