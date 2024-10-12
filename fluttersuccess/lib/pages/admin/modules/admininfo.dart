import 'package:flutter/material.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';
class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
  

    return Column(
      children: [
         const Text("User" ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => Text(
            userProvider.user?.name ?? 'Unknown User', // แสดงชื่อผู้ใช้ ถ้า user ยังไม่ถูกกำหนดจะแสดงข้อความสำรอง
            style: const TextStyle(color: Colors.red, fontSize: 35),
          ),
        ),
        const SizedBox(height: 50),
        const Text("Access Token",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => Text(
            userProvider.accessToken,
            style: const TextStyle(color: Color.fromARGB(255, 255, 26, 129), fontSize: 12),
          ),
        ),
        const SizedBox(height: 16),
        const Text("Refresh Token",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => Text(
            userProvider.refreshToken,
            style: const TextStyle(color: Color.fromARGB(255, 255, 26, 129), fontSize: 12),
          ),
        ),
      ],
    );
  }
}
