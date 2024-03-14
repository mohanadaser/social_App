// ignore_for_file: library_private_types_in_public_api

import 'package:app_social/widgets/posts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                        onPressed: () {}, icon: const Icon(Icons.logout)),
                  ],
                ),
                SizedBox(
                  height: h * 0.15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const Posts();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
