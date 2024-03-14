import 'package:app_social/views/addcomment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

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
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
                ),
                SizedBox(width: w * 0.05),
                const Text(
                  "name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Image(
            fit: BoxFit.cover,
            image: const NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
            height: h * 0.5,
            width: double.infinity,
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            ],
          ),
          const Text("nice photo"),
          TextButton(
              onPressed: () {
                Get.to(() => const AddComment());
              },
              child: const Text("Add Comment")),
          const Text("1 Hour Ago")
        ],
      ),
    );
  }
}
