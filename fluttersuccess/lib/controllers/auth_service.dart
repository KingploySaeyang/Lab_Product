import 'dart:convert';
import 'package:fluttersuccess/varbles.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$apiURL/api/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Parse the user data using UserModel
        UserModel authResponse =
            UserModel.fromJson(jsonDecode(response.body));
        return {
          "success": true,
          "message": authResponse,
        };
      } else {
        // Failed login
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ?? 'Login failed',
        };
      }
    } catch (err) {
      print('Error during login: $err');
      return {
        "success": false,
        "message": "An error occurred. Please try again.",
      };
    }
  }
}
