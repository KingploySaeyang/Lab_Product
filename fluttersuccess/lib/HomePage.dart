import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.pink[400], // ตั้งค่าสีชมพูให้กับ AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300], // 
                foregroundColor: Colors.white, // ตั้งค่าสีตัวอักษรเป็นสีขาว
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // ปรับขนาดปุ่ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // ปรับขอบมนของปุ่ม
                ),
              ),
              child: Text('Login Page'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white, 
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // ปรับขนาดปุ่ม
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // ปรับขอบมนของปุ่ม
                ),
              ),
              child: Text('Register Page'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.pink[30], // ตั้งค่าพื้นหลังของหน้าเป็นสีชมพูอ่อน
    );
  }
}
