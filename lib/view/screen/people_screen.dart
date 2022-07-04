



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme.dart';
import '../widget/people_Widget/show_people_list.dart';



class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
           'People'.tr
        ),
       backgroundColor: Get.isDarkMode?pinkClr:mainColor,
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: ShowPeopleList(),

      )


    );
  }
}
