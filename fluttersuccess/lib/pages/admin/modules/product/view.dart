import 'package:flutter/material.dart';
import 'package:fluttersuccess/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.white, // เปลี่ยนสีของ Card เป็นสีขาว
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(150.0), // ความกว้างของคอลัมน์แรก
                1: FixedColumnWidth(200.0), // ความกว้างของคอลัมน์ที่สอง
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      'Product Name:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.productName),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Type:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.productType),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Price:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.price.toString()),
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                      'Unit(pcs):',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.unit) ,
                  ],
                ),
                // เพิ่มข้อมูลเพิ่มเติมที่ต้องการที่นี่
              ],
            ),
          ),
        ),
      ),
    );
  }
}
