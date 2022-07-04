



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ThemeDarkController{
  //هذا تستخدم بدل sharedpreferences
  final GetStorage storageTheme= GetStorage();
  String keytheme='keythemedark';

  saveThemeDarkData(bool isDark){
    //here even save true or false
    //هنا نحخفظ هل صح او خطاء
    storageTheme.write(keytheme, isDark);

  }
  bool  getThemeDarkFromstorgetheme(){
    // here even get data new false or true
    //هنا نستدعي القيمه هل هي صح او خطاء
    return storageTheme.read<bool>(keytheme)??false;
  }


  ChangeThemedark(){
    //getThemeDarkFromstorgetheme هنا نغير لون على حسب قيمة
    Get.changeThemeMode(getThemeDarkFromstorgetheme()?ThemeMode.light:ThemeMode.dark);
    //هنا نرجع نحفظ  القيمه صج او خطاء
    saveThemeDarkData(!getThemeDarkFromstorgetheme());


  }
  ThemeMode get thememode{
    //هذا نستخدمها في thememode  في صفحه main الرئسية
    return getThemeDarkFromstorgetheme()? ThemeMode.dark:ThemeMode.light;
  }

}