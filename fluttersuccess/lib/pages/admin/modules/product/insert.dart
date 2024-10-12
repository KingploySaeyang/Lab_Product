import 'package:flutter/material.dart';
import 'package:fluttersuccess/controllers/product_controller.dart';
import 'package:fluttersuccess/models/product_model.dart';
import 'package:fluttersuccess/pages/admin/view/AdminPage.dart';
import 'package:fluttersuccess/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  late ProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProductController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productTypeController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _submitProduct(String token) async {
    if (_formKey.currentState!.validate()) {
      final newProduct = ProductModel(
        productName: _productNameController.text,
        productType: _productTypeController.text,
        price: int.parse(_priceController.text),
        unit: _unitController.text,
      );
      try {
        await _controller.postProduct(token, newProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminPage()),
          (route) => false,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<UserProvider>(context).accessToken;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50], // Background color of AppBar
        title: Center( // Center the title
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Add padding
            decoration: BoxDecoration(
              color: Colors.pink, // Background color of the title box
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: Text(
              'Add New Product',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Text color
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.pink[50], // Background color
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            color: Colors.white, // Background color of Card
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding around Card
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16), // Spacing
                    TextFormField(
                      controller: _productTypeController,
                      decoration: InputDecoration(
                        labelText: 'Product Type',
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _unitController,
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        labelStyle: TextStyle(color: Colors.pink),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a unit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _submitProduct(token),
                      child: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.pink, // Button text color
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
