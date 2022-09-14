



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/people_controller.dart';

import '../../../controller/chat_controller.dart';
import '../../../utils/theme.dart';
class AppbarChatWidget extends StatelessWidget implements PreferredSizeWidget{
   AppbarChatWidget({Key? key}) : super(key: key);
  // final controllerPeople= Get.put(PeopleController());
   final controller= Get.find<ChatController>();


   @override
   // TODO: implement preferredSize
   Size get preferredSize => const Size.fromHeight(60);

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  AppBar(
        backgroundColor: Get.isDarkMode? pinkClr:mainColor,
        titleSpacing: 1,
        actions: [
        GetBuilder<PeopleController>(
          init: PeopleController() ,
          builder: (controller) {
          return    IconButton(
              onPressed: (){
            controller.subscribeunsubscribe();
            GetStorage().write('subscrib', controller.subscribe);

          },
              icon: GetStorage().read('subscrib')==true || GetStorage().read('subscrib')==null? Icon(Icons.volume_up_rounded):Icon(Icons.volume_off)
          );

          },
     ),


        ],
        title:   Container(
          child:  Row(
            children: [
              const SizedBox(width: 10,),
              Container(
                width: 50,
                height: 50,
                child: FutureBuilder<DocumentSnapshot>(
                  future: controller.collectionReference.doc(controller.email).get(),
                  builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return  const Text("Dont have image");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {

                      return const CircularProgressIndicator(strokeWidth: 1,);
                    }

                    return  CircleAvatar(

                        backgroundImage:  snapshot.data!['yourtype']=='man'||snapshot.data!['yourtype']=='رجل'?   const AssetImage(
                        'images/man.png'

                        ): const AssetImage(
                          'images/woman.png'
                        )
                    );
                  },
                ) ,
              ),

              const SizedBox(width: 20,),
              Text('Chat'.tr, style: GoogleFonts.cairo()),


            ],

          ),

        )




    );
  }





}
class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}