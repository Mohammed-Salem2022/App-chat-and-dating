


import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watts_gold_almalakiu/controller/people_controller.dart';



class ShowPeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peoplecontrller= Get.put(PeopleController());

    return  GetBuilder<PeopleController>(builder: (contoller){

      return SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream:peoplecontrller.getdataUser(),
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){

                  return const Center(
                    child: CircularProgressIndicator(
                        color: Colors.blue, strokeWidth: 2),
                  );

                }

                else if(!snapshot.hasData){
                  return Center(child: Text('اعمل اعاده تحديث',style: TextStyle(fontSize: 20),),);
                }
                return  GridView.builder(
                    reverse: true ,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.docs.length,
                    gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20
                    ),
                    itemBuilder: (context,index){

                       if(peoplecontrller.user!.email !=snapshot.data?.docs[index]['email'] ) {
                       return  gradView(
                         onTap: (){
                           print(snapshot.data?.docs[index]['Myid']);
                         },
                            index: index,
                            name: snapshot.data?.docs[index]['name'],
                            age: snapshot.data?.docs[index]['age'],
                            country: snapshot.data?.docs[index]['country'],
                            Gender: snapshot.data?.docs[index]['yourtype'],
                        );
                      }else {

                          Visibility(
                            visible: false,
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white.withOpacity(0.3),
                              ),

                            )

                        );


                      }
                         return Divider();

                    }
                );


              })


      );

    }

    );

  }


}
class gradView extends StatelessWidget {
  int index;

  String name;
  String age;
   String country ;
   String Gender ;
  Function() onTap;
  gradView({Key? key,
    required this.index,

    required this.name,
    required this.age,
    required this.country,
    required this.Gender,
    required this.onTap,


  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,

      decoration: BoxDecoration(
          color: Get.isDarkMode?Colors.black:Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap:onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child:Gender=='woman'||Gender=='بنت'?    Image.asset('images/woman.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ):Image.asset('images/man.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

            ),



            Container(

              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
              ),
            ),



            Padding(padding: EdgeInsets.all(10),
                child:    Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name,style: GoogleFonts.almarai(
                            fontWeight: FontWeight.bold,
                            color: Colors.white


                        )
                        ),
                        Text(age,style: GoogleFonts.almarai(
                            fontWeight: FontWeight.bold,
                            color: Colors.white


                        )
                        ),
                      ],

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(country,style: GoogleFonts.almarai(
                            fontWeight: FontWeight.bold,
                            color: Colors.white

                        )
                        ),



                        Text(Gender,style: GoogleFonts.almarai(
                            fontWeight: FontWeight.bold,
                            color: Colors.white


                        )
                        ),
                      ],

                    ),

                  ],
                )


            ),
          ],

        ),
      )
    );
  }
}
