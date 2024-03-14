// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel),
                  iconSize: 30,
                ),
                const Text(
                  "New Post",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Next",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(height: h * 0.4),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.upload,
                  size: 30,
                )),
            const Text("Upload Image"),
            SizedBox(
              height: h * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 100,
                decoration: InputDecoration(
                    hintText: "Add Comment....",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
