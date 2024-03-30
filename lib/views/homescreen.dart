// ignore_for_file: library_private_types_in_public_api

import 'package:app_social/views/loginscreen.dart';
import 'package:app_social/widgets/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Posts",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        icon: const Icon(Icons.logout)),
                  ],
                ),
                SizedBox(
                  height: h * 0.15,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return const Text("error");
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userpost =
                                snapshot.data?.docs[index].data() as  Map<String, dynamic>;

                            return Posts(userpost: userpost);
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
