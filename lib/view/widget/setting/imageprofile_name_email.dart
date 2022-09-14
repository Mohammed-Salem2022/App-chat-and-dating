



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/people_controller.dart';

class ImageProfileName_Email  extends StatelessWidget {
  var email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    Size size1= MediaQuery.of(context).size;
        return  GetBuilder<PeopleController>(
          builder: (controller) {
          return StreamBuilder<DocumentSnapshot>(
            stream:  FirebaseFirestore.instance
                .collection('users').doc(email).snapshots(),

            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return  const Text("Dont have image");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {

                return const CircularProgressIndicator(strokeWidth: 1,);
              }
              return   Padding(padding: EdgeInsets.all(20),
                child:    Column(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor:Colors.white,
                    backgroundImage:snapshot.data!['yourtype']=='woman'||snapshot.data!['yourtype']=='بنت'? AssetImage('images/woman.png'):AssetImage('images/man.png'),
                  ),
                  SizedBox(height: size1.height*0.02,),

                  name_email('${snapshot.data!['name']}',15),

                  SizedBox(height: size1.height*0.00,),
                  name_email('${snapshot.data!['email']}',10),
                  SizedBox(height: size1.height*0.02,),
                  Divider(
                    thickness: 3,
                    color: Get.isDarkMode?Colors.white:Colors.black,
                  )

                ],
                ),
              );
            },
          );

        },);
  }
}



Widget name_email(String? var1,double sizetext){
  return  Container(
    child:   Text('$var1',
      style:GoogleFonts.cairo(
          fontSize: sizetext,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Get.isDarkMode?Colors.white:Colors.black
      ),)
  );
}
