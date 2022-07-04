



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/userInformation_controller.dart';

import '../../../utils/theme.dart';

class DropdownMenuItemWidget extends StatelessWidget {
  final controller=Get.put(UserInformationController());
  List<String> ?list;
  Function onchange;
  String hint;
  String value;
  Widget icon1;
  Function validator;
  DropdownMenuItemWidget({
    Key? key,
    required this.list,
    required this.onchange,
    required this.value,
    required this.hint,
    required this.icon1,
    required this.validator,

  }) :
        super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Center(child:
        DropdownButtonFormField<String>(
         focusColor:Colors.grey.shade200,
         validator: (value)=> validator(value),


          style: GoogleFonts.cairo(
              color:Get.isDarkMode?Colors.white:Colors.black,
              fontWeight: FontWeight.bold
          ),
          decoration: InputDecoration(
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:Get.isDarkMode?pinkClr:Colors.blueAccent,width: 3 ),
            ),
             focusedBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color:Get.isDarkMode?pinkClr:Colors.blueAccent,
                      width: 3
                  ),
             ),
          ),
               hint: Text(hint,
                 style: TextStyle(fontSize: 20,),
               ),

            items: list?.map((age) => DropdownMenuItem(

                value: age,
                child:Padding(padding: EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      icon1,
                      SizedBox(width: 20,),
                      Text(age,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),

                ))).toList(),
          //value: ,
            onChanged: (val)=> onchange(val),
            value:value,


            ),

      );
  }
}
