import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List postData = [];
  bool isLoadingData = false;

  @override
  void initState() {
    isLoadingData = true;
    getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Posts"),
        ),
        body:
        isLoadingData
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child: ElevatedButton(
                child: const Text('Load Posts'),
                  onPressed: () { getAllPosts();
                setState(() {
                  isLoadingData = true;
                });
                }),
              ),
     : ListView.builder(
          itemCount: postData.length,
          itemBuilder: (context, index) {
              return Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${postData[index]['id']} - ${postData[index]['title']}"),
                        const Divider(
                          color: Colors.blue,
                        ),
                        Text("${postData[index]['body']}")
                      ],
                    ),
                  ));
          },
        ),
      );
  }

  Future getAllPosts() async {
    http.Response response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        postData = jsonDecode(response.body);
        isLoadingData = false;
      });

      debugPrint("MYPOSTS --- $postData");
    } else {
      throw Exception("${response.statusCode} - ${response.reasonPhrase}");
    }
  }
}
