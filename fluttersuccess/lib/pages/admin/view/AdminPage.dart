import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fluttersuccess/HomePage.dart';
import 'package:fluttersuccess/controllers/admin_controller.dart';
import 'package:fluttersuccess/pages/admin/modules/admininfo.dart';
import 'package:fluttersuccess/pages/admin/modules/product/index.dart';
import 'package:fluttersuccess/pages/admin/modules/product/insert.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late AdminPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AdminPageController();
  }

  // ฟังก์ชันที่ใช้แสดงหน้าต่างถามเมื่อล็อกเอาท์
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.pink)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.pink)),
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).onLogout();
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink[400],
      ),
      body: IndexedStack(
        index: _controller.selectedIndex,
        children: const [
          UserInfoTab(),
          ProductTab(),
          AddProductPage(),
        ],
      ),
      backgroundColor: Colors.pink[30], // เปลี่ยนพื้นหลังให้เป็นสีชมพูอ่อน
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.pink[300],
        activeColor: Colors.white,
        color: Colors.white,
        items: const [
          TabItem(icon: Icons.person, title: 'User Profile'),
          TabItem(icon: Icons.shopping_cart, title: 'Product'),
          TabItem(icon: Icons.add_box, title: 'Inser Product'),
          TabItem(icon: Icons.logout, title: 'Logout'),
        ],
        initialActiveIndex: _controller.selectedIndex,
        onTap: (int i) {
          if (i == 3) {
            _showLogoutDialog(context);
          } else {
            setState(() {
              _controller.updateIndex(i);
            });
          }
        },
      ),
    );
  }
}
