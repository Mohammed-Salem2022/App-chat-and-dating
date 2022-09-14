

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserAgreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width:Get.width,
      child:Padding(padding: EdgeInsets.all(30),
        child:
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent
              ),
              child: Icon(Icons.check,size: 15,color: Colors.black,),
            ),
            const SizedBox(width: 5,),
            const Text(' I agree to the User Agreement and Privacy Policy',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13),


            )
          ],


        ),
      )





    );
  }
}

