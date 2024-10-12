import 'dart:convert';
import 'package:fluttersuccess/models/product_model.dart';
import 'package:fluttersuccess/varbles.dart';
import 'package:http/http.dart' as http;


class ProductController {


  // Fetch products from the API
  Future<List<ProductModel>> fetchProducts(String token) async {
    final url = Uri.parse('$apiURL/api/product');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> productList = json.decode(response.body);
      return productList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Post a new product to the API
  Future<void> postProduct(String token, ProductModel product) async {
    final url = Uri.parse('$apiURL/api/product');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: productModelToJson(product),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create product');
    }
  }

  // Delete a product from the API
  Future<void> deleteProduct(String token, String productId) async {
    final url = Uri.parse('$apiURL/api/product/$productId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }


  Future<void> updateProduct(String token, ProductModel updatedProduct) async {
    final response = await http.put(
      Uri.parse('$apiURL/api/product/${updatedProduct.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'product_name': updatedProduct.productName,
        'product_type': updatedProduct.productType,
        'price': updatedProduct.price,
        'unit': updatedProduct.unit,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product: ${response.body}');
    }
  }
}
