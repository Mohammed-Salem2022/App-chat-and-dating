
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/language_controller.dart';
import '../../../utils/my_String.dart';
import '../../../utils/theme.dart';
Widget ChangeLanguage(BuildContext context){

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
                  const Icon(Icons.language,size:30,color: Colors.white,),
                    backgroundColor: Get.isDarkMode?  pinkClr:mainColor,
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                  Text(
                    'Language'.tr,
                    style:GoogleFonts.openSans(
                      color:Get.isDarkMode?  Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ) ,
                  ),
                ],
              ),
              DropdownButtonHideUnderline(
                  child:DropdownButton<String>(

                      iconSize: 25,
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: Get.isDarkMode? Colors.white:Colors.black,
                      ),
                      items:  [
                        DropdownMenuItem(
                          value: ara,
                          child:Container(padding: const EdgeInsets.all(10),
                            child: Text(arabic,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),

                        ),
                        DropdownMenuItem(
                          value: ene,
                          child:Container(padding: const EdgeInsets.all(10),
                            child: Text(english,
                              style: const TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),

                        ),
                      ],
                      value: controller.langLocal,
                      onChanged: (value){
                        controller.changelanguage(value!);
                        Get.updateLocale(Locale(value));
                        controller.update();

                      }
                  )
              ),
            ],
          )
      );
    },);
}

