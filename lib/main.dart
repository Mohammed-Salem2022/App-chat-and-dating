






import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'package:watts_gold_almalakiu/routes/routes.dart';
import 'package:watts_gold_almalakiu/utils/dark_mode_colors.dart';
import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/utils/my_String.dart';



import 'controller/theme_controller.dart';
import 'language/localiztion.dart';
import 'model/notification_api.dart';





// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,
//
//       // this will be executed when app is in foreground in separated isolate
//       onForeground: onStart,
//
//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }
//
// // to ensure this is executed
// // run app from xcode, then from xcode menu, select Simulate Background Fetch
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');
//
//   return true;
// }
//
// void onStart(ServiceInstance service) async {
//
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();
//
//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually
//
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.setString("moh", "yesssssssssss");
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // bring to foreground
//   Timer.periodic(const Duration(minutes: 1 ), (timer) async {
//     final hello = preferences.getString("moh");
//     print(hello);
//
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "My App Service",
//         content: "Updated at ${DateTime.now()}",
//       );
//     }
//
//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//
//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }
//
//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }
void main() async {

  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await  initializeService();
 // LocalNotificationService.initialize();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    GetMaterialApp(
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
