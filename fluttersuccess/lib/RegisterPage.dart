import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For jsonEncode
import 'package:fluttersuccess/varbles.dart';
import 'package:fluttersuccess/HomePage.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;
      String name = nameController.text;
      String role = roleController.text;

      // ตรวจสอบ username ในฐานข้อมูล
      final response = await http.post(
        Uri.parse('$apiURL/api/auth/check_username'), // URL สำหรับตรวจสอบ username
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['exists']) {
          // แจ้งเตือนว่า username นี้มีอยู่แล้ว
          _showMessage(context, 'This username already exists.');
        } else {
          // บันทึกข้อมูลลงในฐานข้อมูล
          final registerResponse = await http.post(
            Uri.parse('$apiURL/api/auth/register'), // URL สำหรับบันทึกข้อมูล
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'username': username,
              'password': password,
              'name': name,
              'role': role,
            }),
          );

          if (registerResponse.statusCode == 201) {
            // แจ้งเตือนว่าลงทะเบียนสำเร็จ
            _showMessage(context, 'Registration successful.');

            // นำทางกลับไปยังหน้า home
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false, // Removes all previous routes
            ); // กลับไปยังหน้า HomePage
          } else {
            // แจ้งเตือนข้อผิดพลาดในการลงทะเบียน
            _showMessage(context, 'Registration failed. Please try again.');
          }
        }
      } else {
        // แจ้งเตือนข้อผิดพลาดในการตรวจสอบ username
        _showMessage(context, 'Error checking username. Please try again.');
      }
    }
  }

  void _showMessage(BuildContext context, String message) {
    // ฟังก์ชันสำหรับแสดงข้อความแจ้งเตือน
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink[400], // ตั้งสี AppBar เป็นสีชมพู
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.pink), // เปลี่ยนสีของ label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink), // สีกรอบ
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent), // สีกรอบเมื่อมีการโฟกัส
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // เพิ่มระยะห่าง
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.pink),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.pink),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(color: Colors.pink),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your role';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                  padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // ปรับขนาดปุ่ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // ปรับขอบมนของปุ่ม
                ), //
                ),
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.pink[30],
    );
  }
}
