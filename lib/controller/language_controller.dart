

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/my_String.dart';

class LanguageController extends GetxController {


  GetStorage storage = GetStorage();
  String langLocal = ara;
  bool darkSwich= false;
  Future<String> get readLanguage async {
    return await storage.read('language');
  }

  void saveLanguage(String lang) async {
    await storage.write('language', lang);
    update();
  }

  void changelanguage(String language) {
    if (langLocal == language) {
      update();
      return;
    }
    else if (language == ara) {
      langLocal = ara;
      saveLanguage(langLocal);
      update();
    }
    else if (language == ene) {
      langLocal = ene;
      saveLanguage(langLocal);
      update();
    }
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (!storage.hasData('language')) {
      saveLanguage(langLocal);
    }

    langLocal = await readLanguage;
  }
}