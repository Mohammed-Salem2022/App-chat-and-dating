import 'dart:convert';



import 'package:http/http.dart' as http;
const String serverToken = 'AAAAZVXalwU:APA91bHUP-OOdA105uRbFzFTRNTzmOK6YEq3tW5EIRJZU54oDUw_wcYnaqnluGz26qQikhrIyNW892Wk1EbT6Y00Wd6iyLzS_2x1s1jUQ_evBQsrU8EZgGvTCm8G9Xt5FPoYoUJqfHI4';

   sendnotifiction(String title,String body, String image)async{

     await http.post(
     Uri.parse('https://fcm.googleapis.com/fcm/send')  ,
       headers: <String, String>{
         'Content-Type': 'application/json',
         'Authorization': 'key=$serverToken',
       },
       body: jsonEncode(
         <String, dynamic>{
           'notification': <String, dynamic>{
             'body':  body.toString()  ,
             'title': title.toString()  ,

             "sound" : "default",
             "icon" : 'fcm_push_icon',



           },
           'priority': 'high',
           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
           "android_channel_id": "channel_id_youcreated",
           'data': <String, dynamic>{
             'image':image
             // 'id': '1',
             // 'status': 'done'
           },
           'to':'/topics/groupchat',
         },
       ),
     );





   }