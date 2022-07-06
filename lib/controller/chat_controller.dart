

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/send_information_user.dart';

class ChatController extends GetxController{
 var myid=FirebaseAuth.instance.currentUser?.uid;
 CollectionReference collectionReference= FirebaseFirestore.instance.collection('users');





}