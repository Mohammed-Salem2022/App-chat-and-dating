import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';
import 'package:watts_gold_almalakiu/utils/dark_mode_colors.dart';
import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/utils/my_String.dart';

import 'controller/theme_controller.dart';
import 'language/localiztion.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeApp.light,
        darkTheme: themeApp.dark ,
        themeMode: ThemeDarkController().thememode,
        locale:GetStorage().hasData('language')? Locale(GetStorage().read('language')): Locale(ara),

        translations: LocaliztionApp(),
        fallbackLocale: Locale(ene),

       initialRoute:GetStorage().read('informationUser')==true?NamePages.HomeScreen: GetStorage().read('signGoogle')==true? NamePages.userInformation:NamePages.StartScreen,
        //
        getPages: AppRoutes.routes);
  }
}
