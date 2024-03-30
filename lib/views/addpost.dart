// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:app_social/controllers/firebase_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  FirebaseController firebaseController = Get.put(FirebaseController());
  final comment = TextEditingController();
  File? imageSelected;
  void pickedImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc']);

    if (result == null) {
      print("No file selected");
    } else {
      setState(() {
        imageSelected = File(result.files.single.path ?? "");
      });
    }
  }

  void addPost() async {
    final uuid = const Uuid().v4();
    final ref = FirebaseStorage.instance.ref().child("postsimages").child(uuid);
    await ref.putFile(imageSelected!);
    final imageurl = await ref.getDownloadURL();
    try {
      await FirebaseFirestore.instance.collection("posts").doc(uuid).set({
        "username": firebaseController.userdata?.username,
        "userimage": firebaseController.userdata?.userimage,
        "uid": firebaseController.userdata?.uid,
        "imageposts": imageurl,
        "postid": uuid,
        "comments": comment.text,
        "likes": []
      });
      setState(() {
        imageSelected = null;
        comment.text = '';
      });
      Get.snackbar("Success", "تم ارسال البوست بنجاح",
          backgroundColor: Colors.blue);
    } on FirebaseException catch (e) {
      Get.snackbar("faild", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: GetBuilder<FirebaseController>(
          builder: (firebaseController) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        imageSelected = null;
                        comment.text = '';
                      });
                    },
                    icon: const Icon(Icons.cancel),
                    iconSize: 30,
                  ),
                  const Text(
                    "New Post",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        addPost();
                      },
                      child: const Text(
                        "Publish",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              imageSelected == null
                  ? SizedBox(height: h * 0.4)
                  : Image.file(imageSelected!,
                      height: h * 0.4, width: double.infinity),
              IconButton(
                  onPressed: () {
                    pickedImage();
                  },
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
                  controller: comment,
                  maxLength: 100,
                  decoration: InputDecoration(
                      hintText: "Add Post....",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.white))),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
