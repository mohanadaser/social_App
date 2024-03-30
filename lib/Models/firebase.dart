

import 'package:app_social/Models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethod {
  Future<UserModel> userDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserModel.convertToSnapToModel(snap);
  }

  addLikes({required Map postsmap}) async {
    if (postsmap['likes'].contains(FirebaseAuth.instance.currentUser?.uid)) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postsmap["postid"])
          .update({
        "likes":
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postsmap["postid"])
          .update({
        "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
    }
  }

  deletePost({required Map userdata}) async {
    if (FirebaseAuth.instance.currentUser?.uid == userdata["uid"]) {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(userdata["postid"])
          .delete()
          .then((value) {
        Get.snackbar("Success", "deleted post", backgroundColor: Colors.blue);
      }).catchError((e) {
        print(e.toString());
      });
    }
  }

  addComments(
      {required postid,
      required userimage,
      required uid,
      required comment,
      required name
     }) async {
    final uuid = const Uuid().v4();

   await FirebaseFirestore.instance
        .collection("posts")
        .doc(postid)
        .collection("comments")
        .doc(uuid)
        .set({
          "postid":postid,
          "uid":uid,
          "userimage":userimage,
          "commentid":uuid,
          "comment":comment,
          "name":name
        });
  }
}
