import 'package:app_social/Shared/components.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
                    text: "Search...",
                    type: TextInputType.name,
                    issecure: false,
                    name: name,
                    prifixicon: const Icon(Icons.search)),
                SizedBox(height: h * 0.05),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: h * 0.02);
                      },
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text(
                            "name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1200px-Instagram_icon.png"),
                          ),
                        );
                      },
                      itemCount: 4),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
