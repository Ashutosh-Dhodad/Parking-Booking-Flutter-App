import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:new_parking_app/Services/auth-service.dart';
import 'package:new_parking_app/Views/login-page.dart';

class AuthController {
  static Future<bool> login(String email, String password) async {
    try {
      await AuthService.login(email, password);
      return true;
    } catch (e) {
      log("Login error: $e");
      return false;
    }
  }

  static void logout(BuildContext context) async {
    await AuthService.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }
}
