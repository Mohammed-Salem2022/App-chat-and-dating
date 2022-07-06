import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/view/screen/chat_screen.dart';
import 'package:watts_gold_almalakiu/view/screen/home_screen.dart';
import 'package:watts_gold_almalakiu/view/screen/start_screen.dart';

import '../view/screen/user_information_secreen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: NamePages.StartScreen, page: () => StartScreen()),
    GetPage(name: NamePages.userInformation, page: () => UserInformation()),
    GetPage(name: NamePages.HomeScreen, page: () => HomeScreen()),
    GetPage(name: NamePages.ChatScreen, page: () => ChatScreen()),
  ];
}

class NamePages {
  static const StartScreen = '/StartScreen';
  static const userInformation = '/UserInformation';
  static const HomeScreen = '/HomeScreen';
  static const ChatScreen = '/ChatScreen';
}
