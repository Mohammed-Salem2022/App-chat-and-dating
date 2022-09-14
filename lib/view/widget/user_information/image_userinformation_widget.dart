import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/controller/userInformation_controller.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';

class ImageUserInformationWideget extends StatelessWidget {
  final controller= Get.put(UserInformationController());
  @override
  Widget build(BuildContext context) {
    return Center(
       child:InkWell(

         onTap: (){

             // controller.checkpermissionCamera_Storage();

         },
         child:controller.pickedImagefile==null?
             Stack(
               children: [
                 Container(
                     padding: EdgeInsets.all(5),
                     height: 120,
                     width: 120,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border: Border.all(
                         color:Get.isDarkMode? pinkClr:Colors.blueAccent,
                         width:  4,
                       ),

                     ),
                     child:

                     CircleAvatar(

                       backgroundColor:Get.isDarkMode? pinkClr:Colors.blueAccent,
                       radius: 40,
                       backgroundImage: AssetImage('images/imagepicker.png'),

                     )

                 ),

              Positioned(
                  top: 70,
                  child:  Container(
                    padding: EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,


                    ),

                      child:    Icon(Icons.image,size: 30,color:Colors.white ,))

                  )

               ],

             )



         :
         Container(
           padding: EdgeInsets.all(5),
           decoration: BoxDecoration(
             border: Border.all(
               color:Get.isDarkMode? pinkClr:Colors.blueAccent,
               width:  4,
             ),
             shape: BoxShape.circle

           ),
           child:  CircleAvatar(
             radius: 50,
             backgroundImage: FileImage(
                 controller.pickedImagefile as File

             ),
           ),
         )


       )

    );
  }
}
