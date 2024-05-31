import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class UserServices {
  final box = GetStorage();

  Future<UserModel> login({required String email, required String password}) async {
    var data = {"email": email, "password": password};
    var response = await http.post(
      Uri.parse('$kEndpoint/user/GetUser'),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());
      await saveUser(UserModel.fromJson(json["data"]));
      return UserModel.fromJson(json["data"]);
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
    saveUser(UserModel user) {
    box.remove(kUserInfo);
    box.write(kUserInfo, user.toJson());
  }



  Future<void> ForgetVerifyOtp({required String email, required String otp}) async {
    var data = {
      "email": email,
      "otp": otp,
    };
    var response = await http.post(
      Uri.parse('$kEndpoint/user/ForgetVerifyOtp'),
      body: jsonEncode(data),
      
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());
      print(json["email"]);
      return;
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
    Future<void> resetPassword({required String email, required String newPassword}) async {
    var data = {
      "email": email,
      "newPassword": newPassword
    };
    var response = await http.post(
      Uri.parse('$kEndpoint/user/resetPassword'),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());
      return;
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
class ForgotPasswordServices {
  Future<void> sendResetOTP({required String email}) async {
    var data = {"email": email};
    var response = await http.post(
      Uri.parse('$kEndpoint/user/forgotPassword'),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());
      return;
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}