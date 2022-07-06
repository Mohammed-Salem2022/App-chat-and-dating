


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:watts_gold_almalakiu/routes/routes.dart';

class SiginInController extends GetxController{
 bool progress=false;
 GetStorage checksigninBox=GetStorage();
 User? userid = FirebaseAuth.instance.currentUser;
 bool checkSignUp=false;



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
      progress=true;
      update();
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );
      checkSignUp=true;
      //
      progress=false;
      update();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }



}