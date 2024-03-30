// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:app_social/Models/firebase.dart';
import 'package:app_social/controllers/firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddComment extends StatelessWidget {
  final userpost = Get.arguments;
  AddComment({super.key});

  FirebaseController firebaseController = Get.put(FirebaseController());

  final comments = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          "Comment",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<FirebaseController>(builder: (firebaseController) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .doc(userpost['postid'])
                      .collection("comments")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> commentmap =
                            snapshot.data!.docs[index].data();
                        return ListTile(
                          title: Text(
                            commentmap['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(commentmap['comment']),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(commentmap['userimage']),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                        );
                      },
                    );
                  }),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        firebaseController.userdata?.userimage ?? ''),
                  ),
                  Expanded(
                    child: TextField(
                      controller: comments,
                      maxLength: 100,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (comments.text != '') {
                                  FirebaseMethod().addComments(
                                      postid: userpost['postid'],
                                      userimage: firebaseController
                                          .userdata?.userimage,
                                      uid: firebaseController.userdata?.uid,
                                      comment: comments.text,
                                      name: firebaseController
                                          .userdata?.username);
                                }

                                comments.text = '';
                              },
                              icon: Icon(Icons.send)),
                          hintText: "Add Comment....",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  const BorderSide(color: Colors.white))),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
