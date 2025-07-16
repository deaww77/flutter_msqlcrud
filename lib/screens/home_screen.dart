// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List users = [];

  Future<void> fetchUsers() async {
    var url = Uri.parse('http://10.0.2.2/flutter_crud/api/get_users.php');
    var res = await http.get(url);
    setState(() {
      users = json.decode(res.body);
    });
  }

  Future<void> deleteUser(String id) async {
    var url = Uri.parse('http://10.0.2.2/flutter_crud/api/delete_user.php');
    await http.post(url, body: {'id': id});
    fetchUsers();
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("สมาชิกทั้งหมด")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          var user = users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text(user['email']),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteUser(user['id']),
            ),
          );
        },
      ),
    );
  }
}
