
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class PeopleController extends GetxController{
 User?user= FirebaseAuth.instance.currentUser;




   Stream<QuerySnapshot<Object?>>  getdataUser(){
     CollectionReference  re= FirebaseFirestore.instance.collection('users');
    return  re.orderBy('time').snapshots() ;


  }


 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

}