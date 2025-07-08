// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/snackbar.dart';
import 'package:sri_cuisine/pages/login.dart';
import 'package:sri_cuisine/pages/otpverify.dart';
import 'package:sri_cuisine/pages/resetpassword.dart';
import 'package:sri_cuisine/services/UserApi.dart';
import 'package:http/http.dart' as http;
import 'package:sri_cuisine/routes/api_routes.dart';

class AuthApi {
  static const baseUrl = ApiRoutes.BASE_URL;
  static String userId = '';

  static Future<void> authenticate(
    BuildContext context,
    String username,
    String password,
  ) async {
    Map<String, dynamic> body = {
      'userName': username,
      'password': password,
    };
    try {
      final response = await http.post(
        Uri.parse('${ApiRoutes.BASE_URL}auth'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        UserApi.userId = responseData['user']['_id'];

        UserApi.getUser(context: context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  static Future<void> initiateChangePassword(
    BuildContext context,
    String username,
  ) async {
    Map<String, dynamic> body = {
      'userName': username,
    };
    print('initiateChangePassword(context, username)');
    try {
      final response = await http.post(
        Uri.parse('${ApiRoutes.BASE_URL}auth/reset-request/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        userId = responseData['userId'];
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  static Future<void> verifyOTP(
    BuildContext context,
    int otp,
  ) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'otp': otp,
    };
    try {
      final response = await http.post(
        Uri.parse('${ApiRoutes.BASE_URL}auth/otp/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassPage(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  static Future<void> changePassword(
    BuildContext context,
    String password,
  ) async {
    Map<String, dynamic> body = {
      'newPassword': password,
      'userId': userId,
    };
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiRoutes.BASE_URL}auth/password/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }
}
