import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<dynamic> users = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("REST API CALL"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              final name = user['name'];
              final title = name['title'];
              final first = name['first'];
              final last = name['last'];

              final email = user['email'];

              final avt = user['picture'];
              final avtUrl = avt['thumbnail'];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.network(avtUrl),
                ),
                title: Text("$title $first $last"),
                subtitle: Text(email),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchUser();
          },
          child: const Icon(Icons.add),
        ));
  }

  void fetchUser() async {
    debugPrint("Fetch User called");
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    debugPrint("Fetch User completed");
  }
}
