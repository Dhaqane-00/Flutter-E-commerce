// api_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/User_Order.dart';

import 'package:shop_app/constants.dart';
class UserOrderService {

  Future<List<UserOrder>> fetchUserOrders(String userId) async {
    final response = await http.get(Uri.parse('$kEndpoint/getUserOrder/$userId'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      print(json['data']);
      return (json['data'] as List).map((order) => UserOrder.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }
}
