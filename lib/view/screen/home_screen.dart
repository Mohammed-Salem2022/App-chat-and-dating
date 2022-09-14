


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watts_gold_almalakiu/controller/home_controller.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';
import 'package:watts_gold_almalakiu/utils/theme.dart';



class HomeScreen extends StatelessWidget {
   final controllerhome = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

      return  Obx((){

        return Scaffold(
         backgroundColor: context.theme.backgroundColor,

            bottomNavigationBar:bottomNavigationBarItem(
              homeController:controllerhome ,

            ),
            body:  IndexedStack(
              index: controllerhome.indexScreens.value,
              children: controllerhome.tabs,
            )

        );


      });

 //   });
  }
}
// هنا مربع الي يظهر في الاسفل
 class  bottomNavigationBarItem extends StatelessWidget{
   HomeController homeController;

   bottomNavigationBarItem({
    Key? key,
    required this.homeController,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
       backgroundColor:   Get.isDarkMode?Colors.black:Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Get.isDarkMode?pinkClr:mainColor,
        elevation: 0,
        currentIndex: homeController.indexScreens.value,
        onTap: (index){
           if (index==1){
             Get.toNamed(NamePages.ChatScreen);
           }else {
             homeController.indexScreens.value = index;
           }
        },
        items: const  [
          BottomNavigationBarItem(


            //     activeIcon: Icon(Icons.home,color: Colors.green),
              icon:Icon( Icons.people),
              label: ''
          ),
          BottomNavigationBarItem(

            icon: Icon( Icons.chat_bubble_outlined),
            label: '',
          ),
              BottomNavigationBarItem(

            icon: Icon( Icons.settings),
              label: '',
          ),


        ]

    );
  }



 }