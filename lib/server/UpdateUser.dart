import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/models/UserUpdate.dart';

class UpdateUserService {
  Future<UserUpdate> updateUser({
    required String userId,
    String? name,
    String? email,
    String? password,
    String? role,
    String? address,
    File? photo,
    bool? verify,
    String? otp,
    String? otpExpires,
  }) async {
    var request = http.MultipartRequest('PUT', Uri.parse('$kEndpoint/user/updateUser/$userId'));

    // Add fields to multipart request
    if (name != null) request.fields['name'] = name;
    if (email != null) request.fields['email'] = email;
    if (password != null) request.fields['password'] = password;
    if (role != null) request.fields['role'] = role;
    if (address != null) request.fields['address'] = address;
    if (verify != null) request.fields['verify'] = verify.toString();
    if (otp != null) request.fields['otp'] = otp;
    if (otpExpires != null) request.fields['otpExpires'] = otpExpires;

    // Add file (photo) to multipart request if it exists
    if (photo != null) {
      var photoStream = http.ByteStream(Stream.castFrom(photo.openRead()));
      var length = await photo.length();
      var multipartFile = http.MultipartFile('photo', photoStream, length,
          filename: photo.path.split('/').last); // Adjust filename as needed

      request.files.add(multipartFile);
    }

    // Send request
    var response = await request.send();

    // Handle response
    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      final json = jsonDecode(responseBody.body);
      log(json.toString());
      return UserUpdate.fromJson(json["data"]);
    } else {
      var responseBody = await http.Response.fromStream(response);
      final json = jsonDecode(responseBody.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
