import 'package:app_social/Shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomForm(
                    onchange: (value) {
                      setState(() {});
                      return null;
                    },
                    text: "Search...",
                    type: TextInputType.name,
                    issecure: false,
                    name: name,
                    prifixicon: const Icon(Icons.search)),
                SizedBox(height: h * 0.05),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where('username', isEqualTo: name.text)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(height: h * 0.02);
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  snapshot.data?.docs[index]['username'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      snapshot.data?.docs[index]['userimage']),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length);
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
