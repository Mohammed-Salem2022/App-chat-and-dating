







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/language_controller.dart';
import '../../controller/theme_controller.dart';
import '../../utils/my_String.dart';
import '../../utils/theme.dart';
import '../widget/setting/changeLanguage.dart';
import '../widget/setting/darkmodeWiddget.dart';
import '../widget/setting/defaultDialog_editename.dart';
import '../widget/setting/delete my account.dart';
import '../widget/setting/imageprofile_name_email.dart';
import '../widget/setting/logoutWidget.dart';




class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final controllerLanguage= Get.put(LanguageController());
  bool darkSwich= false;
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: context.theme.backgroundColor,
       appBar: AppBar(
         title: Text(
             'Setting'.tr
         ),
         backgroundColor: Get.isDarkMode?pinkClr:mainColor,
         centerTitle: true,
         actions: [
           popupMenuButton(),

         ],

          ),
        body: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageProfileName_Email(),
            darkmodeWiddget(context),
            ChangeLanguage(context),
            LogoutWidget()


          ],
        ),

      );

    }


}

Widget popupMenuButton(){
  return   PopupMenuButton<Widget>(
    itemBuilder: (context)=> [
      PopupMenuItem(
          child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Text('Name editing'.tr),
          IconButton(
              onPressed: (){
                defaultDialogEditName();
              },

              icon: Icon(Icons.edit,color: Get.isDarkMode?pinkClr:mainColor,))
        ],
      )
      ),
      PopupMenuItem(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text('Delete my account'.tr),
              IconButton(
                  onPressed: (){
                    Delete_my_account();
                  },

                  icon: Icon(Icons.delete,color: Get.isDarkMode?pinkClr:mainColor,))
            ],
          )
      ),
    ],);
}