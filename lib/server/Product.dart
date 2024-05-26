import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

class Product {

  static Future<Map<String, dynamic>> userSignUp(String email, String password) async {
    var url = Uri.parse('$kEndpoint/user/createUser');
    var data = {"email": email, "password": password};

    try {
      final res = await http.post(url, body: data);

      if (res.statusCode == 201) {
        var responseData = json.decode(res.body);
        print("Data: $responseData");


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