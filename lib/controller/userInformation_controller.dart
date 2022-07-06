



import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';
import 'package:watts_gold_almalakiu/view/screen/home_screen.dart';

import '../model/send_information_user.dart';
import '../utils/theme.dart';

class UserInformationController extends GetxController{
  var   userid=FirebaseAuth.instance.currentUser;
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

  pathImage(SendInformationUser sendInformationUser)async{
    //هنا نرفع الصوره الى فايربيس
    progressinformation=true;
    update();

    var path1=basename(pickedImagefile!.path);
    final storage=FirebaseStorage.instance.ref('profileImage/$path1');
    await  storage.putFile( pickedImagefile!);
     final url=await storage.getDownloadURL();

     sendDtatUser(sendInformationUser,url);


    return url;


  }
  sendDtatUser(SendInformationUser sendInformationUser,String url){
   //هنا نرسل البيانات الى فايربيس
    CollectionReference userRef=FirebaseFirestore.instance.collection('users');
    Random random = new Random();
    int randomNumber = random.nextInt(3);

    userRef.doc(userid!.uid).set({
      'Myid':          sendInformationUser.myid,
      'name':           sendInformationUser.name,
      'age':            sendInformationUser.age,
      'country':        sendInformationUser.country,
      'yourtype':       sendInformationUser.yourType,
      'imageProfile':   url,
      'randomNumber':   randomNumber,
      'time':           FieldValue.serverTimestamp(),

    }).then((value) => {

      progressinformation=false,
      informationUser=true,
      getStorageinformationUser.write('informationUser', informationUser),
        update(),
      Get.offNamed(NamePages.HomeScreen)
    });


  }



   // here how take image from gallery and take primission
  final ImagePicker _picker = ImagePicker();
  getImagegallery() async {
    //here get image from phone
    final pickimage = await _picker.pickImage(source: ImageSource.gallery);
    pickedImagefile = File(pickimage!.path);

    update();
    return pickimage;
  }
  checkpermissionCamera_Storage() async {
  //  take primission

    //permission
    var gallerystate = await Permission.storage.status;

    if (!gallerystate.isGranted) {
      await Permission.storage.request().then((value) {
        if(value.isGranted){
          getImagegallery();
        }
      });
    } else if (await gallerystate.isGranted) {
      getImagegallery();
      update();
    }

  }


  List<String> ages=['choose your age'.tr,'18','19','20','21','22','23','24','25','26','27','28','29',
    '30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49',
    '50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65'];
  List<String> yourtype=['Gender'.tr,'man'.tr,'woman'.tr];
  List<String> countries =['اختار دولتك','🇾🇪  اليمن','🇹🇳  تونس','🇸🇾  سوريا','🇹🇷  تركيا','🇪🇬  مصر','🇸🇩  السودان','🇸🇦  السعودية','🇶🇦  قطر','🇮🇶  العراق','🇱🇾  ليبيا',
    '🇲🇦  المغرب', '🇴🇲  عمان' ,'🇦🇪  الامارات' ,'🇰🇼 الكويت', '🇯🇴 الاردن' ,'🇵🇸  فلسطين' ,'🇱🇧  لبنان' ,'🇩🇿  الجزائر' ];
  List<String> countriesEnglish =['Choose your Country'.tr,'🇾🇪  Yemen','🇹🇳  Tunisia','🇸🇾  Syria','🇹🇷  Turkey','🇪🇬  Egypt','🇸🇩  Sudan','🇸🇦  Saudi Arabia','🇶🇦  Qatar','🇮🇶  Iraq','🇱🇾  Libya',
    '🇲🇦  Morocco', '🇴🇲  Amman' ,'🇦🇪  UAE' ,'🇰🇼 Kuwait', '🇯🇴 Jordan' ,'🇵🇸  Palestine' ,'🇱🇧  Lebanon' ,'🇩🇿  Algeria' ];



}