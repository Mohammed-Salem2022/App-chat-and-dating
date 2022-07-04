





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/language_controller.dart';
import '../../controller/theme_controller.dart';
import '../../utils/my_String.dart';
import '../../utils/theme.dart';




class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final controllerLanguage= Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
        init:LanguageController() ,
        builder: (controller){
      return Scaffold(
        backgroundColor: context.theme.backgroundColor,
       appBar: AppBar(

         title: Text(
        'Setting'.tr
       ),
          backgroundColor: Get.isDarkMode?pinkClr:mainColor,
          centerTitle: true,
          ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:  MaterialButton(
                color: Colors.blueAccent,
                onPressed: (){
                  ThemeDarkController().ChangeThemedark();

                },

                child: Text('Dark mode'.tr) ,
              ),

            ),

            Center(
              child:  MaterialButton(
                color: Colors.blueAccent,
                onPressed: (){

                  controllerLanguage.changelanguage(ene);
                  Get.updateLocale(Locale(ene));

                },

                child: Text('save Language') ,
              ),


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
        ),

      );

    });
  }
}
