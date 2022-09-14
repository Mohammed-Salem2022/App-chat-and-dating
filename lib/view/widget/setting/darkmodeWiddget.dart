import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/language_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../utils/theme.dart';


Widget darkmodeWiddget (BuildContext context){
  return GetBuilder<LanguageController>(
    init: LanguageController(),
    builder: (controller) {
      return  Padding(padding: EdgeInsets.all(15),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(child:
                  const Icon(Icons.dark_mode,size:30,color: Colors.deepPurple,),
                    backgroundColor: Get.isDarkMode?  pinkClr:mainColor,
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                  Text(
                    'DarkMode'.tr,
                    style:GoogleFonts.openSans(
                      color:Get.isDarkMode?  Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ) ,
                  ),
                ],
              ),
              Switch(
                  activeColor: Get.isDarkMode?pinkClr:mainColor,
                  activeTrackColor: Get.isDarkMode?pinkClr:mainColor,
                  value:controller.darkSwich ,

                  onChanged: (value){
                    ThemeDarkController().ChangeThemedark();

                    controller. darkSwich=value;
                  }
              )
            ],
          )
      );
    },);
}