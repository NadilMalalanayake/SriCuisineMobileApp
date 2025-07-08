import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/snackbar.dart';
import 'package:sri_cuisine/pages/specification_page.dart';
import 'package:sri_cuisine/models/user.dart';
import 'package:sri_cuisine/pages/login.dart';
import 'package:sri_cuisine/pages/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sri_cuisine/routes/api_routes.dart';

class UserApi {
  static const baseUrl = ApiRoutes.BASE_URL;
  static String userId = '';
  static String userEmail = '';
  static User user = User();

  static Future<void> getUser({
    required BuildContext context,
  }) async {
    try {
      var headers = {"Content-Type": "application/json"};

      final response = await http.get(
        Uri.parse('${baseUrl}users/$userId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        final responseData = json.decode(response.body);
        user = User.fromJson(responseData);
        print(user.toJson());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        // If the server returns an unexpected response, log the status code and response body.
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // If an error occurs, log the error message and throw an exception.
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<void> createUser({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      print("username:$userName");
      print("email:$email");
      print("password:$password");

      var body = {
        'userName': userName,
        'email': email,
        'password': password,
      };

      var headers = {"Content-Type": "application/json"};

      final response = await http.post(Uri.parse(baseUrl + 'users/'),
          headers: headers, body: jsonEncode(body));

      print(response.body);

      if (response.statusCode == 201) {
        // If the server returns a 200 OK response, parse the JSON.
        final responseData = json.decode(response.body);
        userId = responseData['_id'];
        userEmail = responseData['email'];
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SpecPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        // If the server returns an unexpected response, log the status code and response body.
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // If an error occurs, log the error message and throw an exception.
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
      errorSnackBar(e.toString()),
      );
      throw Exception('Failed to load data: $e');
    }
  }

  static Future<void> updateUser({
    required BuildContext context,
    required List<String> allergens,
    required double height,
    required String userId,
    required double weight,
    required int age,
  }) async {
    try {
      var body = {
        'userId': userId,
        'email': userEmail,
        'allergens': allergens,
        'height': height,
        'weight': weight,
        'age': age
      };

      var headers = {"Content-Type": "application/json"};

      final response = await http.put(Uri.parse('${baseUrl}users'),
          headers: headers, body: jsonEncode(body));

      print(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        // If the server returns an unexpected response, log the status code and response body.
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(json.decode(response.body)['message']),
        );
        throw Exception('Failed to update user');
      }
    } catch (e) {
      // If an error occurs, log the error message and throw an exception.
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
      throw Exception('Failed to update user: $e');
    }
  }

  static Future<void> updateUserDetails({
    required BuildContext context,
    required double height,
    required double weight,
    required int age,
  }) async {
    try {
      var body = {
        'userId': user.id,
        'email': user.email,
        'allergens': user.allergens,
        'height': height,
        'weight': weight,
        'age': age
      };

      var headers = {"Content-Type": "application/json"};

      final response = await http.put(Uri.parse('${baseUrl}users'),
          headers: headers, body: jsonEncode(body));

      print(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        getUser(context: context).whenComplete(() {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false,
          );
        });
      } else {
        // If the server returns an unexpected response, log the status code and response body.
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
         ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
        throw Exception('Failed to update user');
      }
    } catch (e) {
      // If an error occurs, log the error message and throw an exception.
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
      errorSnackBar(e.toString()),
      );
      throw Exception('Failed to update user: $e');
    }
  }
}
