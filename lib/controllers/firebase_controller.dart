// ignore_for_file: avoid_print

import 'package:app_social/Models/firebase.dart';
import 'package:app_social/Models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  UserModel? userdata;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  void fetchUserDetails() async {
    try {
      UserModel user = await FirebaseMethod().userDetails();
      userdata = user;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  
}
