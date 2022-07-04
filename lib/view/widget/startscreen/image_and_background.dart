

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ImageAndBackground extends StatelessWidget {
  const ImageAndBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

       children: [

         Center(
           child:
           Container(
           width: 150,
              height: 150,
             child: const CircleAvatar(
               backgroundImage: NetworkImage(
                   'https://images.unsplash.com/photo-1611606063065-ee7946f0787a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',

               ),
            ),
           ),
         ),
         const SizedBox(height: 20,),
         Center(
            child:
             Text('دردشة مع البنات',
               style:GoogleFonts.cairo(
                 fontWeight: FontWeight.bold,
                 color: Colors.red,
                 fontSize: 22),
             )
         ),
       ],
     );



  }
}
