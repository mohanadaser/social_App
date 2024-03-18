// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:io';

import 'package:app_social/Shared/components.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var username = TextEditingController();
  var emailaddress = TextEditingController();
  var password = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                              if (formKey.currentState!.validate()) {}
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
