// screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String msg = "";

  Future<void> register() async {
    var url = Uri.parse('http://10.0.2.2/api/register.php');
    var response = await http.post(
      url,
      body: {
        'name': nameCtrl.text,
        'email': emailCtrl.text,
        'password': passCtrl.text,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = json.decode(response.body);
    if (data['success']) {
      Navigator.pop(context);
    } else {
      setState(() {
        msg = "ลงทะเบียนไม่สำเร็จ: ${data['error']}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน"),
        backgroundColor: const Color.fromARGB(255, 69, 255, 171),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "ชื่อ"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: "อีเมล"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "รหัสผ่าน"),
            ),
            ElevatedButton(onPressed: register, child: Text("สมัครสมาชิก")),
            Text(msg, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
