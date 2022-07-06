



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/chat_controller.dart';
import '../../../utils/theme.dart';
class AppbarChatWidget extends StatelessWidget implements PreferredSizeWidget{
   AppbarChatWidget({Key? key}) : super(key: key);
  final controller= Get.put(ChatController());
   @override
   // TODO: implement preferredSize
   Size get preferredSize => const Size.fromHeight(60);

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  AppBar(//title: Text('Chat'.tr),
        backgroundColor: Get.isDarkMode? pinkClr:mainColor,
        titleSpacing: 1,
        title:   Container(



          child:  Row(


            children: [



              const SizedBox(width: 10,),

              Container(
                width: 50,
                height: 50,
                child: FutureBuilder<DocumentSnapshot>(
                  future: controller.collectionReference.doc(controller.myid).get(),
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

                        backgroundImage: NetworkImage(
                          snapshot.data!['imageProfile'],

                        )
                    );
                  },
                ) ,),

              const SizedBox(width: 20,),
              Text('Chat'.tr, style: GoogleFonts.cairo()),


            ],

          ),

        )




    );
  }





}