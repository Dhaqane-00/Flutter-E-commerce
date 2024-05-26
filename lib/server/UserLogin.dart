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
      return UserModel.fromJson(json["data"]);
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
