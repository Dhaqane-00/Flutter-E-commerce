import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

class UserSignUp {
  static String email = '';

  static Future<Map<String, dynamic>> userSignUp(String email, String password) async {
    var url = Uri.parse('$kEndpoint/user/createUser');
    var data = {"email": email, "password": password};

    try {
      final res = await http.post(url, body: data);

      if (res.statusCode == 201) {
        var responseData = json.decode(res.body);
        print("Data: $responseData");

        // Store email for OTP verification
        UserSignUp.email = email;

        // After signup, proceed to OTP verification
        return {'status': 'success', 'message': 'Signup successful. Please verify OTP.', 'email': email};
      } else if (res.statusCode == 400) {
        print("Bad Request: User already exists");
        debugPrint(res.body);
        return {'status': 'error', 'message': 'User already exists'};
      } else {
        print("Failed to get response");
        debugPrint(res.body);
        return {'status': 'error', 'message': 'Server error'};
      }
    } catch (e) {
      debugPrint(e.toString());
      return {'status': 'error', 'message': 'Exception occurred'};
    }
  }
}

class OTP {
  static Future<Map<String, dynamic>> otpVerification(String otp) async {
    var url = Uri.parse('$kEndpoint/user/verifyOTP');
    var data = {"email": UserSignUp.email, "otp": otp};

    try {
      final res = await http.post(url, body: data);

      if (res.statusCode == 200) {
        var responseData = json.decode(res.body);
        print("Data: $responseData");
        return {'status': 'success', 'message': '', 'email': UserSignUp.email};
      } else if (res.statusCode == 400) {
        print("Bad Request: User");
        debugPrint(res.body);
        return {'status': 'error', 'message': 'OTP Error or Expired'};
      } else {
        print("Failed to get response");
        debugPrint(res.body);
        return {'status': 'error', 'message': 'Server error'};
      }
    } catch (e) {
      debugPrint(e.toString());
      return {'status': 'error', 'message': 'Exception occurred'};
    }
  }
}
