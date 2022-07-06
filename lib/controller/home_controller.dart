

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/screen/people_screen.dart';
import '../view/screen/setting_screen.dart';

class HomeController extends GetxController{
   RxInt indexScreens=0.obs;

  final tabs=[
    PeopleScreen(),
    Container(),
    SettingScreen()



  ].obs;





}