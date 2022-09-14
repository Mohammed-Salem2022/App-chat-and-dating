



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/view/widget/chat/mailer_box_widget.dart';


import '../../controller/chat_controller.dart';
import '../../controller/home_controller.dart';
import '../widget/chat/appbar_chat_widget.dart';
import '../widget/chat/friends_online.dart';
import '../widget/chat/messageIn_chat.dart';

class ChatScreen extends StatelessWidget{
   ChatScreen({Key? key}) : super(key: key);

   // final controllerChat1=Get.lazyPut(()=> ChatController(),fenix: false);
   final controllerChat1= Get.find<ChatController>();
   //  debugPrint("Message");

   @override

  Widget build(BuildContext context) {
    // TODO: implement build

    return   WillPopScope(
        onWillPop: ()async{

               // controllerChat1.update();
          return true;
        },
        child:  Scaffold(

            backgroundColor: context.theme.backgroundColor,
            appBar:AppbarChatWidget(),
            body: Container(
                decoration:  const BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage(
                          "images/background1.jpg"
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop)
                  ),
                ),
                child:
                Stack(

                  children: [



                    Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        MessageInChat(),
                        MailerBoxWidget(),


                      ],
                    ),
                    FriendOnline(),

                  ],
                )
            )




        ),


    );




  }



}
