import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/chat_controller.dart';

class FriendOnline extends StatelessWidget {
  // final controllerChat=Get.put(ChatController());

  final controllerChat= Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {

    return  Container(

        padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
        width: double.infinity,
        height: Get.height*0.11,
        color: Colors.black45,
        child:   StreamBuilder<QuerySnapshot>(
            stream: controllerChat.collectionReference.where('Status', isEqualTo: 'online').snapshots(),
            builder:(
                    (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){

                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 2
                          ),
                        );

                      }

                      else if(!snapshot.hasData){
                        return const Center(
                          child: Text(
                            'اعمل اعاده تحديث',
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        );
                      }
             return  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return controllerChat.myid==snapshot.data?.docs[index]['Myid']?Container():
                      Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(
                                snapshot.data?.docs[index]['imageProfile']
                            ),
                          ),
                              const SizedBox(
                                width: 70,
                              ),
                           Center(
                               child:Text(
                                 snapshot.data?.docs[index]['name'],
                                 style: const TextStyle(
                                     color: Colors.white
                                 ),
                               )
                      ),
                        ],
                      );
                    },
             );

                })
        )
    );
  }
}
