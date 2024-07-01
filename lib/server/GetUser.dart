import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';

class GetUserService {
  Future<UserModel?> fetchUserById(String id) async {
    final url = Uri.parse('$kEndpoint/user/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = UserModel.fromJson(data['data']);
        return user;
      } else {
        log('Failed to load user: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error fetching user: $e');
      return null;
    }
  }
}
