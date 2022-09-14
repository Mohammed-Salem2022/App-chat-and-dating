



import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../utils/downloadAndSavePicture.dart';



class LocalNotificationService {

  static  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin2 = FlutterLocalNotificationsPlugin();
  static void initialize() {
    final InitializationSettings initializationSettings =
     InitializationSettings(
       android: AndroidInitializationSettings("@mipmap/ic_launcher")
     );
    flutterLocalNotificationsPlugin2.initialize(initializationSettings);
  }

 static Future<void> showNotificationMediaStyle(RemoteMessage message) async {
   Random random =  Random();
   int id = random.nextInt(1000);
    final String? largeIconPath = await downloadAndSaveFile(
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg', 'largeIcon');
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'mychanel',
      'media channel name',
      channelDescription: 'media channel description',
      largeIcon:  FilePathAndroidBitmap(largeIconPath!),
      // styleInformation:  MediaStyleInformation(),
      importance: Importance.max,
      priority: Priority.max

    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin2.show(
        0,  message.notification!.title,  message.notification!.body, platformChannelSpecifics);


 }
  static Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin2.cancel(0);
  }
//   static void display(RemoteMessage message) async{
//     try {
//       print("In Notification method");
//       // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
//       var  largeiconpath= await Utils.downloadAndSavePicture1(
//         'https://firebasestorage.googleapis.com/v0/b/watts-gold-almalky.appspot.com/'
//             'o/profileImage%2Fimage_picker1228336032425556526.jpg?alt=media&token=c8511107-5bc0-4c8a-8f1b-0eb1c84bd014',
//         'largeIcon',
//       );
//       // final styleInformation= BigPictureStyleInformation(
//       //   FilePathAndroidBitmap(largeiconpath!),
//       //   largeIcon: FilePathAndroidBitmap(largeiconpath!),
//       // );
//       Random random = new Random();
//       int id = random.nextInt(1000);
//       AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
//           "mychanel",
//           "my chanel",
//         showBadge: true,
//         importance: Importance.max,
//         enableLights: true,
//         description: 'ssssssssssssssss',
//
//       );
//
//       final NotificationDetails notificationDetails = NotificationDetails(
//
//            android: AndroidNotificationDetails(
//             "mychanel",
//             "my chanel",
//             importance: Importance.max,
//             priority: Priority.max,
//             enableVibration: true,
               // styleInformation:styleInformation,
//            largeIcon:  DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
//
//
//           )
//       );
//
//
//       // await flutterLocalNotificationsPlugin2
//       //     .resolvePlatformSpecificImplementation<
//       //     AndroidFlutterLocalNotificationsPlugin>()
//       //     ?.createNotificationChannel(androidNotificationChannel);
//       await flutterLocalNotificationsPlugin2.show(
//
//         1,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//
//       );
//     } on Exception catch (e) {
//       print('Error>>>$e');
//     }
//
//
// }
 static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin2.cancelAll();
  }

 static  notificationPermission() async {
   FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

  }

}
