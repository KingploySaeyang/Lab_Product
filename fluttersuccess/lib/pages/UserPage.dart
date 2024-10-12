import 'package:flutter/material.dart';
import 'package:fluttersuccess/controllers/product_controller.dart';
import 'package:fluttersuccess/models/product_model.dart';
import 'package:fluttersuccess/pages/admin/modules/product/view.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttersuccess/HomePage.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.user?.name ?? 'Unknown User'; // ดึงชื่อผู้ใช้ปัจจุบัน

    return Scaffold(
      appBar: AppBar(
        title: Text('User Page - $username'), // แสดงชื่อผู้ใช้ใน AppBar
        backgroundColor: Colors.pink[400], // ตั้งค่าสีของ AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // ไอคอนล็อกเอาท์
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // แสดงชื่อผู้ใช้ที่ด้านบน
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, $username!',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.pink, // เปลี่ยนสีของข้อความ
              ),
            ),
          ),
          // แสดงรายการสินค้าใต้ชื่อผู้ใช้
          Expanded(
            child: ProductList(), // ใช้ ProductList ที่มีปุ่ม "ดูรายละเอียด"
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // ตั้งค่าพื้นหลัง
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิดหน้าต่างและกลับไปหน้าเดิม
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // ลบข้อมูลการล็อกอินทั้งหมด
                Provider.of<UserProvider>(context, listen: false).onLogout();
                Navigator.of(context).pop(); // ปิดหน้าต่าง
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false, // Removes all previous routes
                ); // กลับไปยังหน้า HomePage
              },
            ),
          ],
        );
      },
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductController _controller;
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    _controller = ProductController();
    final token = Provider.of<UserProvider>(context, listen: false).accessToken;
    futureProducts = _controller.fetchProducts(token);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: FutureBuilder<List<ProductModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.pink[50], // Card color
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.pink, // Text color
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Type: ${product.productType}',
                          style: const TextStyle(fontSize: 16, color: Colors.pink), // Text color
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () async {
                            // แสดงรายละเอียดของสินค้า
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(product: product),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // Button color
                          ),
                          child: const Text('View Details', style: TextStyle(color: Colors.pink)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _refreshProducts() async {
    final token = Provider.of<UserProvider>(context, listen: false).accessToken;
    setState(() {
      futureProducts = _controller.fetchProducts(token);
    });
  }
}
