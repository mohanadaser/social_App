import 'package:app_social/views/addpost.dart';
import 'package:app_social/views/homescreen.dart';
import 'package:app_social/views/profile.dart';
import 'package:app_social/views/searchscreen.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List baritems = [
    const HomeScreen(),
    const SearchScreen(),
    const AddPost(),
    const ProfileScreen()
  ];
  int currentindex = 0;
  void pagelist(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: baritems[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: pagelist,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.grey),
              label: "Search",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.grey),
              label: "AddPost",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.grey),
              label: "Profile",
              backgroundColor: Colors.black)
        ],
        fixedColor: Colors.white,
      ),
    );
  }
}
