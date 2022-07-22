



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/view/widget/chat/mailer_box_widget.dart';


import '../../controller/chat_controller.dart';
import '../widget/chat/appbar_chat_widget.dart';
import '../widget/chat/friends_online.dart';
import '../widget/chat/messageIn_chat.dart';
class ChatScreen extends StatelessWidget{
   ChatScreen({Key? key}) : super(key: key);
   final controllerChat=Get.put(ChatController());
   @override
   //  debugPrint("Message");

   @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return   Scaffold(

            backgroundColor: context.theme.backgroundColor,
            appBar:AppbarChatWidget(),
            body: Container(
                decoration:  const BoxDecoration(

                  image: DecorationImage(
                      image: NetworkImage(
                          "https://img.freepik.com/free-photo/black-painted-wall-textured-background_"
                              "53876-110728.jpg?size=626&ext"
                              "=jpg&uid=R74153960&ga=GA1.2.500750962.1629025686"
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




        );





  }



}
