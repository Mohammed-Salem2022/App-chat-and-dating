



import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';


import '../model/notification_api.dart';
import '../model/send_information_user.dart';
import '../utils/theme.dart';

class UserInformationController extends GetxController{
  var   userid=FirebaseAuth.instance.currentUser;
  var email = FirebaseAuth.instance.currentUser?.email;
  bool    progressinformation=false;
  String  selectedAge='choose your age'.tr;
  String   selectedyourKind='Gender'.tr;
  String  selectedcountry='Choose your Country'.tr;
  File?   pickedImagefile;
  GetStorage getStorageinformationUser=GetStorage();
  bool informationUser=false;

     defDialog({
    required Function () onPressed1,
    required Function () onPressed2,
       required String title,
       required String middleText,
       required String text1,
       required String text2,
}){

      Get.defaultDialog(
               title: title,
               titleStyle: TextStyle(color: Colors.red),
               middleText: middleText,
    actions: [
                MaterialButton(
                   onPressed: onPressed1,
                 shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                   child: Text(text1,style:  TextStyle(color: Colors.white),),
                   color: mainColor,

                ),
                  MaterialButton(
                    onPressed: onPressed2,
                   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                     color: mainColor,
                     child: Text(text2,style: const TextStyle(color: Colors.white),),

  )

  ]


  );

}

  // pathImage(SendInformationUser sendInformationUser)async{
  //   //هنا نرفع الصوره الى فايربيس
  //   progressinformation=true;
  //   update();
  //
  //   var path1=basename(pickedImagefile!.path);
  //   final storage=FirebaseStorage.instance.ref('profileImage/$path1');
  //   await  storage.putFile( pickedImagefile!);
  //    final url=await storage.getDownloadURL();
  //
  //    sendDtatUser(sendInformationUser,'data:image/jpeg;base64,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');
  //
  //
  //   return url;
  //
  //
  // }
  sendDtatUser(SendInformationUser sendInformationUser)async{
   //هنا نرسل البيانات الى فايربيس
    CollectionReference userRef=FirebaseFirestore.instance.collection('users');
    Random random = new Random();
    int randomNumber = random.nextInt(3);

    userRef.doc(userid!.email).set({
      'email':           userid?.email,
      'name':           sendInformationUser.name,
      'age':            sendInformationUser.age,
      'country':        sendInformationUser.country,
      'yourtype':       sendInformationUser.yourType,

      'randomNumber':   randomNumber,
      'time':            FieldValue.serverTimestamp(),
      'Status':          'false',
       'token':         await  FirebaseMessaging.instance.getToken(),
       'count':         1
    }).then((value) => {

      progressinformation=false,
      informationUser=true,
      getStorageinformationUser.write('informationUser', informationUser),
        update(),
      Get.offNamed(NamePages.HomeScreen)
    });

    //
  }



   // here how take image from gallery and take primission
  // final ImagePicker _picker = ImagePicker();
  // getImagegallery() async {
  //   //here get image from phone
  //   final pickimage = await _picker.pickImage(source: ImageSource.gallery);
  //   pickedImagefile = File(pickimage!.path);
  //
  //   update();
  //   return pickimage;
  // }
  // checkpermissionCamera_Storage() async {
  // //  take primission
  //
  //   //permission
  //   var gallerystate = await Permission.storage.status;
  //
  //   if (!gallerystate.isGranted) {
  //     await Permission.storage.request().then((value) {
  //       if(value.isGranted){
  //         getImagegallery();
  //       }
  //     });
  //   } else if (await gallerystate.isGranted) {
  //     getImagegallery();
  //     update();
  //   }
  //
  // }


  List<String> ages=['choose your age'.tr,'18','19','20','21','22','23','24','25','26','27','28','29',
    '30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49',
    '50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65'];
  List<String> yourtype=['Gender'.tr,'man'.tr,'woman'.tr];
  List<String> countries =['اختار دولتك','🇾🇪  اليمن','🇹🇳  تونس','🇸🇾  سوريا','🇹🇷  تركيا','🇪🇬  مصر','🇸🇩  السودان','🇸🇦  السعودية','🇶🇦  قطر','🇮🇶  العراق','🇱🇾  ليبيا',
    '🇲🇦  المغرب', '🇴🇲  عمان' ,'🇦🇪  الامارات' ,'🇰🇼 الكويت', '🇯🇴 الاردن' ,'🇵🇸  فلسطين' ,'🇱🇧  لبنان' ,'🇩🇿  الجزائر' ];
  List<String> countriesEnglish =['Choose your Country'.tr,'🇾🇪  Yemen','🇹🇳  Tunisia','🇸🇾  Syria','🇹🇷  Turkey','🇪🇬  Egypt','🇸🇩  Sudan','🇸🇦  Saudi Arabia','🇶🇦  Qatar','🇮🇶  Iraq','🇱🇾  Libya',
    '🇲🇦  Morocco', '🇴🇲  Amman' ,'🇦🇪  UAE' ,'🇰🇼 Kuwait', '🇯🇴 Jordan' ,'🇵🇸  Palestine' ,'🇱🇧  Lebanon' ,'🇩🇿  Algeria' ];

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
   userRef.where('email' ,isEqualTo: email).get().then((value) => {

        if(value.docs.isNotEmpty){
          Get.offNamed(NamePages.HomeScreen)
        },



   });

  }
// @override
//   void onClose() {
//     // TODO: implement onClose
//     super.onClose();
//     debugPrint('----------information--------------');
//   }
}