import 'dart:convert';

import 'package:api/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<User> users = [];

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
              final name = user.name.first;
              final email = user.email;
              final genderColor =
                  user.gender == "male" ? Colors.red : Colors.blue;

              // final name = user['name'];
              // final title = name['title'];
              // final first = name['first'];
              // final last = name['last'];

              // final email = user['email'];

              // final avt = user['picture'];
              // final avtUrl = avt['thumbnail'];
              return ListTile(
                title: Text(user.name.first),
                tileColor: genderColor,
                subtitle: Text(user.cell),
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

    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      final name = userName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last']);
      return User(
          gender: e['gender'],
          name: name,
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat']);
    }).toList();
    setState(() {
      users = transformed;
    });
    debugPrint("Fetch User completed");
  }
}
