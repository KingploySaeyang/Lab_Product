import 'package:flutter/material.dart';
import 'package:fluttersuccess/controllers/product_controller.dart';
import 'package:fluttersuccess/models/product_model.dart';
import 'package:fluttersuccess/pages/admin/modules/product/edit.dart';
import 'package:fluttersuccess/pages/admin/modules/product/view.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductTab extends StatelessWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<UserProvider>(context).accessToken;
    return ProductList(token: token);
  }
}

class ProductList extends StatefulWidget {
  final String token;

  const ProductList({required this.token, Key? key}) : super(key: key);

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
    futureProducts = _controller.fetchProducts(widget.token);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(product: product),
                                  ),
                                );
                                if (result == true) {
                                  setState(() {
                                    futureProducts = _controller.fetchProducts(widget.token);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Button color
                              ),
                              child: const Text('View Details',style: TextStyle(color: Colors.pink)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProductPage(product: product),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Button color
                              ),
                              child: const Text('Edit',style: TextStyle(color: Colors.pink)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showDeleteDialog(product);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // Keep Delete button red
                              ),
                              child: const Text('Delete',style: TextStyle(color: Colors.white)),
                            ),
                          ],
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
    setState(() {
      futureProducts = _controller.fetchProducts(widget.token);
    });
  }

  void _showDeleteDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text('Are you sure you want to delete ${product.productName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(product);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(ProductModel product) async {
    await _controller.deleteProduct(widget.token, product.id.toString());
    setState(() {
      futureProducts = _controller.fetchProducts(widget.token);
    });
  }
}
