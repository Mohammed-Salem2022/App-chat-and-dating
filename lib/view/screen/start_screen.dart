import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign_in_controoler.dart';
import '../widget/startscreen/image_and_background.dart';
import '../widget/startscreen/sign_in_button.dart';
import '../widget/startscreen/user_ agreement_Widget.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SiginInController>(
        init: SiginInController(),
        builder: (controller){
      return Scaffold(

          body: SafeArea(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children:   [

                const SizedBox(height: 10,),
                ImageAndBackground(),

                const SizedBox(height: 10,),
                Column(children: [
                  Center(child:controller.progress?
                  CircularProgressIndicator(color: Colors.red,):  DesginButtonSginIn(),
                  ),


                  UserAgreement(),

                ],),
                const SizedBox(height: 3,),
              ],
            ),

          )
      );

    });
  }
}
