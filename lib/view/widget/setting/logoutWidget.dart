




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';
import '../../../utils/theme.dart';

class LogoutWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Sgin_OutdefaultDialog();




        },
       splashColor:Get.isDarkMode?pinkClr:mainColor,
        child:  Padding(padding: EdgeInsets.all(15),
            child: Row(children: [
              Container(
                padding: EdgeInsets.all(6),


                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:Get.isDarkMode? Color(0xff6132e4):mainColor

                ),
                child: Icon(Icons.exit_to_app_outlined),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              Container(
                  // splashColor:Get.isDarkMode? pinkClr: mainColor,
                  // customBorder: StadiumBorder(),
                  child: Text(
                    'Sgin Out'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode?Colors.white:Colors.black ,
                        fontSize: 25
                    ),

                  ) ,

              )

            ],)

        )
      );


  }
}
Future<dynamic>Sgin_OutdefaultDialog(){
  GoogleSignIn userGoogle= GoogleSignIn();
  return  Get.defaultDialog(
      title: 'Sgin Out'.tr,
      middleText: 'Do you want Exit'.tr,
      actions: [
        MaterialButton(
          onPressed: (){
            Get.back();
          },
          child: Text('No'.tr),


        ),
        MaterialButton(
          onPressed: () async {
         userGoogle.signOut();
         Get.offNamed(NamePages.StartScreen);

          },
          child: Text('Yes'.tr),


        )

      ]
  );


}