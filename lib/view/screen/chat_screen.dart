



import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widget/chat/appbar_chat_widget.dart';
class ChatScreen extends StatelessWidget{
   ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:AppbarChatWidget(),

      );

  }



}