import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostRequestPage extends StatefulWidget {
  const PostRequestPage({Key? key}) : super(key: key);

  @override
  _PostRequestPageState createState() => _PostRequestPageState();
}

class _PostRequestPageState extends State<PostRequestPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  Map<String, dynamic> responseData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
            ),
            TextFormField(
              controller: jobController,
            ),
            ElevatedButton(
                onPressed: () {
                  postNameJob();
                },
                child: const Text("Post data")),
            Visibility(
              visible: responseData.isNotEmpty,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Name"),
                      trailing: Text("${responseData['name']}"),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Job"),
                      trailing: Text("${responseData['job']}"),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Id"),
                      trailing: Text("${responseData['id']}"),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("created At"),
                      trailing: Text("${responseData['createdAt']}"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  postNameJob() async {
    String url = "https://reqres.in/api/users";
    Map<String, dynamic> body = {
      "id": "247",
      "name": nameController.text,
      "job": jobController.text
    };
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      setState(() {
        responseData = jsonDecode(response.body);
      });
      debugPrint("$responseData");
    } else {
      debugPrint("${response.statusCode}");
    }
  }
}
