// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String msg = "";

  Future<void> login() async {
    var url = Uri.parse('http://10.0.2.2/flutter_crud/api/login.php');
    var response = await http.post(
      url,
      body: {'email': emailCtrl.text, 'password': passCtrl.text},
    );

    var data = json.decode(response.body);
    if (data['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        msg = data['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เข้าสู่ระบบ"),
        backgroundColor: const Color.fromARGB(255, 69, 255, 171),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "อีเมล"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "รหัสผ่าน"),
            ),
            ElevatedButton(onPressed: login, child: Text("เข้าสู่ระบบ")),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: Text("สมัครสมาชิก"),
            ),
            Text(msg, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
