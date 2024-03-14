// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddComment extends StatefulWidget {
  const AddComment({Key? key}) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("coment"),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite),
                  ),
                );
              },
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
                ),
                Expanded(
                  child: TextField(
                    maxLength: 100,
                    decoration: InputDecoration(
                        hintText: "Add Comment....",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.white))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
