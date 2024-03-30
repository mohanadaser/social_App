// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';

import 'package:app_social/Models/usermodel.dart';
import 'package:app_social/Shared/components.dart';
import 'package:app_social/views/bottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  var username = TextEditingController();
  var emailaddress = TextEditingController();
  var password = TextEditingController();
  final formKey = GlobalKey<FormState>();

 @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
    
  }
  @override
  void dispose() {
    username.dispose();
    emailaddress.dispose();
    password.dispose();
    super.dispose();
  }

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

  void login() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailaddress.text, password: password.text);
      final uuid = const Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child("userimage").child("${uuid}jpg");
      await ref.putFile(imageSelected!);
      final imageurl = await ref.getDownloadURL();
      //========================================================لتخزين صوره مع id عشوائى
      UserModel user = UserModel([], [], emailaddress.text, password.text,
          username.text, imageurl, FirebaseAuth.instance.currentUser!.uid);
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.convrtToMap());
      //===================================================save userdata in firebasestore
      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (context) {
      //   return const BottomBarScreen();
      // }));
      Get.off(() => const BottomBarScreen());
      setState(() {
        isloading = false;
      });
    } on FirebaseException catch (err) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
         isloading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Center(
                child: Text(
                  "App Social",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: h * 0.05),
              Stack(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: imageSelected != null
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage: FileImage(imageSelected!))
                        : const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
                          ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      onPressed: () async {
                        pickedImage();
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomForm(
                        text: "Name",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يجب ادخال الاسم";
                          }
                          return null;
                        },
                        type: TextInputType.name,
                        issecure: false,
                        name: username),
                    CustomForm(
                        text: "Email",
                        type: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يجب ادخال الايميل";
                          }
                          return null;
                        },
                        issecure: false,
                        name: emailaddress),
                    CustomForm(
                        text: "password",
                        type: TextInputType.visiblePassword,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "يجب ادخال الباسورد";
                          }
                          return null;
                        },
                        issecure: true,
                        name: password,
                        sufixicon: const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        )),
                    SizedBox(height: h * 0.05),
                    SizedBox(
                        height: h * 0.05,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: isloading == true
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
