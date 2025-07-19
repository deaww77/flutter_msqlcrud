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
    var url = Uri.parse('http://10.0.2.2/flutter_crud/api/register.php');

    try {
      var response = await http.post(
        url,
        body: {
          'name': nameCtrl.text,
          'email': emailCtrl.text,
          'password': passCtrl.text,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Raw Response Body: ${response.body}');

      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        var data = json.decode(response.body);
        if (data['success']) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('ลงทะเบียนสำเร็จ'),
              content: Text('คุณสามารถเข้าสู่ระบบได้แล้ว'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('ตกลง'),
                ),
              ],
            ),
          );
        } else {
          setState(() {
            msg = " ลงทะเบียนไม่สำเร็จ: ${data['error'] ?? 'Unknown error'}";
          });
        }
      } else {
        setState(() {
          msg = "ไม่ได้ JSON: ${response.body}";
        });
      }
    } catch (e) {
      print('ERROR: $e');
      setState(() {
        msg = "เกิดข้อผิดพลาด: $e";
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
