// ignore_for_file: must_be_immutable

import 'package:app_social/Models/firebase.dart';
import 'package:app_social/views/addcomment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Posts extends StatelessWidget {
  Map<String, dynamic> userpost;
  Posts({super.key, required this.userpost});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userpost["userimage"]),
                ),
                SizedBox(width: w * 0.05),
                Text(
                  userpost["username"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    FirebaseMethod().deletePost(userdata: userpost);
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                )
              ],
            ),
          ),
          Image(
            fit: BoxFit.cover,
            image: NetworkImage(userpost["imageposts"]),
            height: h * 0.5,
            width: double.infinity,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  FirebaseMethod().addLikes(postsmap: userpost);
                },
                icon: const Icon(Icons.favorite),
                color: userpost["likes"]
                        .contains(FirebaseAuth.instance.currentUser?.uid)
                    ? Colors.red
                    : Colors.white,
              ),
              Text("${userpost["likes"].length} likes"),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            ],
          ),
          const Text("nice photo"),
          TextButton(
              onPressed: () {
                Get.to(() =>  AddComment(),arguments:userpost);
              },
              child: const Text("Add Comment")),
          const Text("1 Hour Ago")
        ],
      ),
    );
  }
}
