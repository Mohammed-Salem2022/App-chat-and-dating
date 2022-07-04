





import 'package:flutter/material.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';

import 'package:get/get.dart';

class ButtonInformation extends StatelessWidget {
  Function() onPressed;
  ButtonInformation({
    Key,key,
    required this.onPressed,


  })
      :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        child: MaterialButton(
          color: Get.isDarkMode?pinkClr:   mainColor,

          splashColor: Get.isDarkMode?mainColor:   pinkClr,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
          onPressed:onPressed,
          child:  Text(
            'save'.tr,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
        )

      )
    );
  }


}
