import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomForm(
        {required String text,
        required TextInputType type,
        required bool issecure,
        final String? Function(String?)? validator,
        final String?Function(String?)?onchange,
        Icon? prifixicon,
        Icon? sufixicon,
        required TextEditingController name}) =>
    Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          autofocus: true,
          onChanged: onchange,
          validator: validator,
          controller: name,
          obscureText: issecure,
          keyboardType: type,
          decoration: InputDecoration(
              prefixIcon: prifixicon,
              suffix: sufixicon,
              filled: true,
              fillColor:Colors.black,
              labelText: text),
        ));

// ignore: non_constant_identifier_names
Widget CustomMatrialButton(
        {required Color color,
        required String text,
        required void Function()? onpress}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      margin: const EdgeInsets.all(15),
      height: 40,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onpress,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  
  Widget customUploadBottun(
        {
        required String text,
       // required bool isselected,
        required void Function()? onpress}) =>
    Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
       // color:isselected==true?Colors.green:Colors.red
      ),
      margin: const EdgeInsets.all(15),
      height: 40,
      width: 80,
      child: MaterialButton(
        onPressed: onpress,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
