





import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/controller/theme_controller.dart';
import 'package:watts_gold_almalakiu/controller/userInformation_controller.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';
import 'package:watts_gold_almalakiu/view/widget/text_faild.dart';
import 'package:watts_gold_almalakiu/view/widget/user_information/image_userinformation_widget.dart';

import '../../controller/theme_controller.dart';
import '../../model/send_information_user.dart';
import '../../utils/my_String.dart';
import '../widget/dropdown_ menu/dropdown_menu.dart';
import '../widget/user_information/button_information_widget.dart';


class UserInformation extends StatelessWidget {
   final controller = Get.put(ThemeDarkController());

   final keyform=GlobalKey<FormState>();
   TextEditingController textEditingName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<UserInformationController>(
        init: UserInformationController(),
        builder: (controllerinformation){
      return Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(title: Text('User Information'.tr,style: GoogleFonts.cairo(),
          ),
            backgroundColor: Get.isDarkMode?pinkClr:mainColor,
            elevation: 0,
            centerTitle: true,


          ),

          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(15),
              child: Form(
                key: keyform,
                  child: Column(
                      children: [

                        ImageUserInformationWideget(),
                        SizedBox(height: 20,),
                        TextFaild(
                            controller1: textEditingName,
                            obscureText1:false ,
                            textInputType: TextInputType.name,
                            validator: (value){
                              if(textEditingName.text.isEmpty  ){
                                return 'Enter your name'.tr;
                              }

                              if(value.length<=3){
                                return 'Your name must be more than 3 letters'.tr;
                              }
                            },
                            prefixIcon: Icon(Icons.person,color:Get.isDarkMode?Colors.white: Colors.black),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  textEditingName.clear();
                                },
                                icon:  const Icon(Icons.close)) ,
                            label: const Text('ادخل اسمك'),
                            maxLength: 10
                        ),
                        const SizedBox(height: 20,),
                        DropdownMenuItemWidget(
                          hint: 'choose your age',
                          icon1: const Icon(Icons.date_range),
                          list: controllerinformation.ages,
                          onchange: (yourage){
                            controllerinformation.selectedAge=yourage;
                          },
                          validator: (val){
                            if( controllerinformation.selectedAge =='choose your age'.tr){
                              return 'choose your age';
                            }
                            return null;
                          },
                          value: controllerinformation.selectedAge,
                        ),
                        const SizedBox(height: 15,),
                        DropdownMenuItemWidget(
                          hint: 'الجنس',
                          icon1: Icon(Icons.person),
                          list: controllerinformation.yourtype,
                          onchange: (yourtype){

                            controllerinformation.selectedyourKind=yourtype;
                          },
                          validator: (val){
                            if(  controllerinformation.selectedyourKind =='Gender'.tr){
                              return 'اختار جنسك';
                            }
                            return null;
                          },
                          value: controllerinformation.selectedyourKind,
                        ),
                        const SizedBox(height: 15,),
                        DropdownMenuItemWidget(
                          hint: 'اختار دولتك',
                          icon1: Icon(Icons.flag_circle_rounded),
                          list: controllerinformation.countriesEnglish,
                          onchange: (country){
                            controllerinformation.selectedcountry=country;
                          },
                          validator: (val){

                            if( controllerinformation.selectedcountry =='Choose your Country'.tr){
                              return 'Choses country';
                            }
                            return null;
                          },
                          value: controllerinformation.selectedcountry,
                        ),
                        const SizedBox(height: 15,),
                         controllerinformation.progressinformation?CircularProgressIndicator(color: Colors.redAccent,strokeWidth: 3,)
                         :ButtonInformation(
                          onPressed: (){


                                if(keyform.currentState!.validate()) {


                                 final sendInformationUser= SendInformationUser(

                                     name: textEditingName.text ,
                                     age: controllerinformation.selectedAge,
                                     yourType: controllerinformation.selectedyourKind,
                                     country: controllerinformation.selectedcountry,
                                     myid: controllerinformation.userid?.uid,
                                 );
                                controllerinformation.sendDtatUser(sendInformationUser);

                                }





                          },
                        )
                      ]
                  ),

              )
            ),
          )
      );
   });
  }
}
