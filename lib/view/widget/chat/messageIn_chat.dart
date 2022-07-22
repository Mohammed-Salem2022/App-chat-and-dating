








import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:watts_gold_almalakiu/controller/chat_controller.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';

import '../../../utils/my_String.dart';
class MessageInChat extends StatelessWidget {
  //هنا عرض محادثه من فايربيس
   final controllerChat=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
                     stream:controllerChat.collectionReferenceChat
                      .orderBy('time', descending: true).snapshots(),
                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
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
              return GetBuilder<ChatController>(
                builder:(controller){
               //

            //        return  Expanded(
            //          child: GroupedListView<dynamic, String>(
            //            reverse:  false,
            //            order: GroupedListOrder.ASC,
            //              useStickyGroupSeparators: false,
            //             floatingHeader: true,
            //
            //             physics:  BouncingScrollPhysics(),
            //              elements:snapshot.data!.docs.toList(),
            //             groupBy: (element)  {
            //
            //                return element['time']==null?'': controller.date(element['time']);
            //            },
            //            groupSeparatorBuilder:(element)
            //
            //                =>element==null?const Text('0'):  SizedBox(
            //                 height: 40,
            //                 child: Center(
            //                   child: Card(
            //                      child: Padding(
            //                          padding: EdgeInsets.all(8),
            //                        child: Text(
            //                       element
            //
            //                       ),
            //                      ),
            //                   ),
            //                   ),
            //                ),
            //             itemBuilder: (context,  e) {
            //               controllerChat.mytext =controllerChat.myid==e['myid'];
            //                 return  UiSendAndreply(
            //                     name:      e['name'],
            //                     message:   e['message'],
            //                     randome:   e['randomNumber'],
            //                     image:     e['imageProfile'],
            //                     time:      e['time'] ==null? Timestamp.now():e['time'],
            //             );
            //            }
            //
            //   )
            // );
                 return Expanded(child:
                 ListView.builder(
                     itemCount: snapshot.data?.docs.length,
                     reverse:  true,
                     physics:  BouncingScrollPhysics(),
                     itemBuilder: (context,index){
                       controllerChat.mytext =controllerChat.myid==snapshot.data?.docs[index]['myid'];
                       Timestamp time =  snapshot.data?.docs[index]['time'] ?? Timestamp.now();

                      controllerChat.myid!=snapshot.data?.docs[0]['myid']? controllerChat.readMessageOrNot('true'):null;
                       return  UiSendAndreply(
                         name:      snapshot.data?.docs[index]['name'],
                         message:   snapshot.data?.docs[index]['message'],
                         randome:   snapshot.data?.docs[index]['randomNumber'],
                         image:     snapshot.data?.docs[index]['imageProfile'],
                         time:      time,
                       );

                     })

                 );




         }
          );

      }
      );



  }

}
class UiSendAndreply extends StatelessWidget{
  //هنا تصميم صفحه المحادثه
    String name;
    String message;
    int randome;
    String image;
    Timestamp time ;
  UiSendAndreply({
    Key? key,
    required this.name,
    required this.message,
    required this.randome,
    required this.image,
    required this.time,
  }) : super(key: key);
  final controllerChat2=Get.put(ChatController());



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Align(
      alignment: GetStorage().read('language')==ene ?controllerChat2.mytext?Alignment.centerRight: Alignment.centerLeft:
                                                      controllerChat2.mytext?Alignment.centerLeft: Alignment.centerRight,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:  MediaQuery.
            of(context).
            size.width - 60,
          ),
          // child:  Expanded(
          child:
          Row(

           mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
           // crossAxisAlignment:GetStorage().read('language')==ene? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [

              controllerChat2.mytext==false?  CircleAvatar(
                backgroundImage: NetworkImage(
                 image
                ),

              ):Container(),
              Expanded(
                child: Column(
                 crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
                    children: [
                      Bubble(
                        nipWidth:10,
                          margin: BubbleEdges.only(top: 10, left:5,right: 5 ),
                          alignment:GetStorage().read('language')==ene?
                          controllerChat2.mytext?
                          Alignment.topRight:
                          Alignment.topLeft:controllerChat2.mytext?
                          Alignment.topLeft: Alignment.topRight,
                          nip:GetStorage().read('language')==ene?
                          controllerChat2.mytext? BubbleNip.rightTop:
                          BubbleNip.leftTop:controllerChat2.mytext?
                          BubbleNip.leftTop: BubbleNip.rightTop,
                       //   color: Color.fromRGBO(225, 255, 199, 1.0),


                       color: controllerChat2.mytext? mainColor:Colors.blue,
                        child:MessageNameinsideContainer(
                          //هنا تصميم الاسم ورسالة والوقت داخل container
                          name: name,
                          randome: randome,
                          message: message,
                          time: time,
                        ),

                      )




                    ],
                  ),

              ),





            ],
          )
      //    )
      ),
    );
  }


}
class MessageNameinsideContainer extends StatelessWidget{
  //هنا تصميم الاسم ورسالة والوقت داخل container
  String name;
  String message;
  int randome;
  Timestamp time;
  MessageNameinsideContainer({
    Key? key,
    required this.name,
    required this.message,
    required this.randome,
    required this.time,
  }) : super(key: key);
  final controllerChat2=Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Stack(
      children: [
        GetStorage().read('language')==ene? controllerChat2.mytext? Padding(padding: const EdgeInsets.only(
            left:10,
            right: 60,
            bottom: 20,
            top: 5

        ),
            child:   Column(
              children: [
                SizedBox(height: 3,),
                Text(message,
                  maxLines: 10,
                  style: const TextStyle(
                    height: 1,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            )
        ): Padding(

            padding: const EdgeInsets.only(
                left:10,
                right: 60,
                bottom: 20,
                top: 5

            ),
            child:   Column(
              crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(name,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color:randome==1?  Colors.white:randome==2?Colors.greenAccent:randome==0?Colors.yellow:Colors.black
                  ),
                ),
                const SizedBox(height: 3,),
                Text(message,
                  maxLines: 10,
                  style: const TextStyle(
                    height: 1,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            )
        ):controllerChat2.mytext? Padding(padding: const EdgeInsets.only(
            left:60,
            right: 10,
            bottom: 20,
            top: 5

        ),
            child:   Column(
              //  crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3,),
                Text(message,
                  maxLines: 10,
                  style: const TextStyle(
                    height: 1,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            )
        ): Padding(

            padding: const EdgeInsets.only(
                left:60,
                right: 10,
                bottom: 20,
                top: 5

            ),
            child:   Column(
              crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(name,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color:randome==1?  Colors.white:randome==2?Colors.greenAccent:randome==0?Colors.yellow:Colors.black
                  ),
                ),
                SizedBox(height: 3,),
                Text(message,
                  maxLines: 10,
                  style: const TextStyle(
                    height: 1,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            )
        ),
        GetStorage().read('language')==ene ?  Positioned(
            bottom: 4,
            right: 10,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children:  [

                Text(controllerChat2.time(time)),
                const SizedBox(width: 5,),
                const Text('m')

              ],)

        ):Positioned(
            bottom: 4,
            left: 10,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children:  [
                Text(controllerChat2.time(time)),
                SizedBox(width: 5,),
                Text('30:6')

              ],)

        )

      ],
    );
  }



}
class xxx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: BubbleEdges.only(top: 10),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      color: Color.fromRGBO(225, 255, 199, 1.0),
      child: Text('Hello, World!', textAlign: TextAlign.right),

    );
  }
}

