// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_social/controllers/firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseController firebaseController = Get.put(FirebaseController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<FirebaseController>(
                builder: (firebaseController) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                firebaseController.userdata?.userimage ?? ""),
                          ),
                          Column(
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "11",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "8",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        firebaseController.userdata?.username ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {},
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("posts")
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser?.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 2,
                              childAspectRatio: 2.5 / 3,
                              children: List.generate(
                                  snapshot.data!.docs.length, (index) {
                                return Image.network(
                                    snapshot.data?.docs[index]['imageposts']);
                              }));
                        })
                  ],
                ),
              ))),
    );
  }
}
