




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/chat_controller.dart';

import '../../../model/send_talk_to_chat.dart';
import '../../../utils/theme.dart';


class MailerBoxWidget extends StatelessWidget{
  final controllerChat=Get.put(ChatController());
  String? text;
   MailerBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.all(5),
      child:  Container(

        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade400,
        ) ,
        child: Row(

          children: [
              Expanded(

                    child:  Container(
                     padding: EdgeInsets.all(3),
                      child:  TextField(

                       controller:controllerChat. textMessage.value,
                        maxLines: 3,
                        minLines: 1,
                        style: const TextStyle(

                          color: Colors.black,),
                          decoration:  InputDecoration(
                            hintText: 'Message'.tr,
                          hintStyle: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.normal),
                          fillColor:Get.isDarkMode? Colors.grey.shade400:Colors.grey.shade400,
                          filled: true,
                           prefixIcon:  Icon(
                            Icons.emoji_emotions,
                            color: Get.isDarkMode? Colors.red:Colors.black,

                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value){

                       controllerChat.textbool=  value.isEmpty;
                       controllerChat.update();

                        },
                      ),
                     )
         ),

          GetBuilder<ChatController>(
              builder: ((controller) {

            return    StreamBuilder<QuerySnapshot>(
                stream:controllerChat.collectionReferenceChat
                    .orderBy('time', descending: true).snapshots(),
                builder: (context, snapshot1) {
              return FutureBuilder<DocumentSnapshot>(
                  future: controllerChat.collectionReference.doc(controllerChat.myid).get(),
                  builder: (context, snapshot) {
                    return  controllerChat.textbool?Container():
                    IconButton(

                        splashColor: Get.isDarkMode? pinkClr:mainColor,
                        onPressed: () {
                          if (snapshot1.data!.docs.length > 30) {
                               controllerChat.deleteAlldecomtion();
                               final sendMessageToChat = SendMessageToChat(
                                 myid: snapshot.data!['Myid'],
                                 name: snapshot.data! ['name'],
                                 message: controllerChat.textMessage.value.text,
                                 imageprofile: snapshot.data!['imageProfile'],
                                 randomNumber: snapshot.data!['randomNumber'],
                               );

                               if (controllerChat.textbool) {

                               } else {
                                 controllerChat.textMessage.value.clear();
                                 controllerChat.textbool = true;
                                 controllerChat.sendMessageToChat(
                                     sendMessageToChat);
                                 controllerChat.update();
                               }
                          } else {

                            final sendMessageToChat = SendMessageToChat(
                              myid: snapshot.data!['Myid'],
                              name: snapshot.data! ['name'],
                              message: controllerChat.textMessage.value.text,
                              imageprofile: snapshot.data!['imageProfile'],
                              randomNumber: snapshot.data!['randomNumber'],
                            );

                            if (controllerChat.textbool) {

                            } else {
                              controllerChat.textMessage.value.clear();
                              controllerChat.textbool = true;
                              controllerChat.sendMessageToChat(
                                  sendMessageToChat);
                              controllerChat.update();
                            }
                       }

                        },
                        icon:controllerChat.textbool ==false?   const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ):const Visibility(
                          visible:  true,
                          child:Icon(
                            Icons.send,
                            color: Colors.black,
                          ) ,
                        )
                    );
                  }
              );
            });

          }
          )
          )


          ],
        ),

      )
    );



  }




}