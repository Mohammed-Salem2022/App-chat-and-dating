








import 'package:timeago/timeago.dart' as timeago;
import 'dart:ui';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/chat_controller.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';


import '../../../model/notification_api.dart';
import '../../../utils/my_String.dart';
class MessageInChat extends StatelessWidget {
  //هنا عرض محادثه من فايربيس
  //  final controllerChat=Get.put(ChatController());
  final controllerChat= Get.find<ChatController>();
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
                 return Expanded(child:
                 ListView.builder(

                     itemCount: snapshot.data!.docs.isEmpty?snapshot.data?.docs.length:snapshot.data!.docs.length-1,
                     reverse:  true,
                     physics:  BouncingScrollPhysics(),
                     itemBuilder: (context,index){
                       controllerChat.mytext =controllerChat.email==snapshot.data?.docs[index]['email'];
                       Timestamp time =  snapshot.data?.docs[index]['time'] ?? Timestamp.now();
                       Timestamp time2 =snapshot.data?.docs[index+1]['time'];


                   //  controllerChat.myid!=snapshot.data?.docs[0]['myid']? controllerChat.readMessageOrNot('true'):null;

                       return  UiSendAndreply(
                                 name:      snapshot.data?.docs[index]['name'],
                                 iduser:    snapshot.data?.docs[index]['email'] ,
                                 isDelete:  snapshot.data?.docs[index]['isDelete'],
                                 message:   snapshot.data?.docs[index]['message'],
                                 randome:   snapshot.data?.docs[index]['randomNumber'],
                                 image:     snapshot.data?.docs[index]['imageProfile'],
                                 time:      time,
                                 time2:     time2,
                                 myText: controller.mytext,
                                 index:     snapshot.data?.docs[index]['isRead'] ,
                                 decomtionid:snapshot.data?.docs[index]['decomtionid'] ,
                               );


                 //
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
    String iduser;
    String isDelete;
    bool myText;
    String message;
    int randome;
    String image;
    Timestamp time ;
    Timestamp time2 ;
    String decomtionid ;
    String index;
  UiSendAndreply({
    Key? key,
    required this.name,
    required this.iduser,
    required this.message,
    required this.isDelete,
    required this.randome,
    required this.myText,
    required this.image,
    required this.time,
    required this.time2,
    required this.index,
    required this.decomtionid,
  }) : super(key: key);
  final controllerChat2=Get.put(ChatController());
    CustomPopupMenuController _controller = CustomPopupMenuController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return    Column(
               children: [

                 Container(
                   padding: const EdgeInsets.only(top: 1),
                   child:   Center(

                     child:controllerChat2.datelist(time)!=controllerChat2.datelist(time2)?
                     Text(controllerChat2.datelist(time),
                       style: const TextStyle(
                           color: Colors.white
                       ),
                     ):Container(),
                   ),
                 ),

        Align(

        alignment: GetStorage().read('language')==ene ?controllerChat2.mytext?Alignment.centerRight: Alignment.centerLeft:
             controllerChat2.mytext?Alignment.centerLeft: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
             maxWidth:  MediaQuery.
              of(context).
             size.width - 60,
            ),

             child:Row(

             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment:CrossAxisAlignment.start,

              children: [

               controllerChat2.mytext==false?
               CircleAvatar(
               backgroundImage:image=='بنت'||image=='woman'? const AssetImage(
                'images/woman.png'
               ):
               AssetImage('images/man.png'),
              ):Container(),
              Expanded(
                  child: Column(
                   crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
                    children: [
                      CustomPopupMenu(
                        menuBuilder: () => ClipRRect(

                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: const Color(0xFF4C4C4C),
                            child: IntrinsicWidth(

                              child:myText? Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children:[

                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child:Container(
                                          padding: const EdgeInsets.only(left: 20, top: 0,bottom: 0,right: 20),
                                        width: Get.width*0.33,
                                        child:  Row(children: const [
                                          Text('Delete',style: TextStyle(color: Colors.white),),
                                          SizedBox(width: 20,),
                                          Icon(Icons.delete,color:Colors.white ,),
                                    ],)
                                      ),
                                      onTap: (){

                                       controllerChat2.deleteMydecomtiononly(isDelete);
                                        _controller.hideMenu();
                                      },
                                    )
                                  ]
                              ):Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children:[

                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child:Container(
                                          // ignore: prefer_const_constructors
                                          padding: EdgeInsets.only(left: 20, top: 0,bottom: 0,right: 20),
                                          width: Get.width*0.33,
                                          child:  Row(children: const [
                                            Text('Report',style: TextStyle(color: Colors.white),),
                                            SizedBox(width: 20,),
                                            Icon(Icons.report,color:Colors.white ,),
                                          ],)
                                      ),
                                      onTap: (){

                                       controllerChat2.reportUser(
                                           idImReport: controllerChat2.myid!,
                                           idUser: iduser,
                                           nameuser: name,
                                           message: message
                                       );
                                        _controller.hideMenu();
                                      },
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ),
                        pressType: PressType.singleClick,
                        verticalMargin: -10,
                        controller: _controller,
                        child:Bubble(
                          nipWidth:10,
                          margin: const BubbleEdges.only(top: 7, left:5,right: 5 ),
                          alignment:GetStorage().read('language')==ene?
                          controllerChat2.mytext?
                          Alignment.topRight:
                          Alignment.topLeft:controllerChat2.mytext?
                          Alignment.topLeft: Alignment.topRight,
                          nip:GetStorage().read('language')==ene?
                          controllerChat2.mytext? BubbleNip.rightTop:
                          BubbleNip.leftTop:controllerChat2.mytext?
                           BubbleNip.leftTop: BubbleNip.rightTop,
                          color: controllerChat2.mytext? mainColor:Colors.blue,
                           child:MessageNameinsideContainer(
                             //هنا تصميم الاسم ورسالة والوقت داخل container
                            name: name,
                            randome: randome,
                            message: message,
                            time: time,
                            decomtionid: decomtionid,
                            index: index,
                       ),

                       ),
                      ),





                    ],
                   ),

                ),

               ],
               )
                   ),
                     ),
               ],
    );
  }


}
class MessageNameinsideContainer extends StatelessWidget{
  //هنا تصميم الاسم ورسالة والوقت داخل container
  String name;
  String message;
  int randome;
  Timestamp time;
  String decomtionid;
  String index;
  MessageNameinsideContainer({
    Key? key,
    required this.name,
    required this.index,
    required this.message,
    required this.randome,
    required this.time,
    required this.decomtionid,
  }) : super(key: key);
  final controllerChat2=Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String timeago2 = timeago.format(time.toDate(),locale: 'en_short');




    return  Stack(
      children: [
        GetStorage().read('language')==ene? controllerChat2.mytext? Padding(padding: const EdgeInsets.only(
            left:10,
            right: 60,
            bottom: 10,
            top: 0

        ),
            child:   Column(
              children: [

                SizedBox(height: 3,),
                Text(message,
                  maxLines: 10,
                  style: const TextStyle(
                    height:1,
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
                bottom: 10,
                top: 0

            ),
            child:   Column(

              crossAxisAlignment:controllerChat2.mytext? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(name,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
            bottom: 10,
            top: 0

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
                bottom: 10,
                top: 0

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
            bottom: -4,
            right: 10,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children:  [

                controllerChat2.gettimeago(timeago2)?
                Text(timeago.format(time.toDate(),locale: 'en_short'))
                :
                Text(controllerChat2.time(time)),
                const SizedBox(width: 5,),
                controllerChat2.mytext?index=='true'? const Icon(Icons.check_box,size: 18,):
                decomtionid=='1'? const Icon(Icons.check,size: 18,):
                const Icon(Icons.timer,size: 18,):
                Container()
              ],)

        ):Positioned(
            bottom: -4,
            left: 10,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //timeago.format(time.toDate(),locale: 'en_short')
              //controllerChat2.time(time)
              children:  [


                controllerChat2.gettimeago(timeago2)?
                Text(timeago.format(time.toDate(),locale: 'en_short')) :
                Text(controllerChat2.time(time)),
                const SizedBox(width: 5,),

                   controllerChat2.mytext?index=='true'? const Icon(Icons.check_box,size: 18,):
                   decomtionid=='1'? const Icon(Icons.check,size: 18,):
                   const Icon(Icons.timer,size: 18,):
                   Container()



              ],)

        )

      ],
    );
  }



}
