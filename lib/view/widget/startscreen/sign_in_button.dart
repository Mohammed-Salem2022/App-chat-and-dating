import 'package:flutter/material.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';
import 'package:get/get.dart';

import '../../../controller/sign_in_controoler.dart';
import '../../../routes/routes.dart';
class DesginButtonSginIn extends StatelessWidget {
   DesginButtonSginIn({Key? key}) : super(key: key);
   final controller=Get.put(SiginInController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20),
        child: InkWell(
          onTap: ()async{
               await  controller.signInWithGoogle().then((value) {
             controller.    checksigninBox.write('signGoogle',controller. checkSignUp);
             Get.offNamed(NamePages.userInformation);
               });

          },
          child: Stack(children: [
            Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/google.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Google',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ],
                )

            ),


          ],)
        )
      ),
    );
  }
}
