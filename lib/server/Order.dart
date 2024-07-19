import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Order.dart';

class OrderServices {
  Future<Order> order({
    required String user,
    required String payment,
    required List<Map<String, dynamic>> products, // Correct type
    required double total,
    required String note,
    required String phone,
  }) async {
    var data = {
      "user": user,
      "payment": payment,
      "products": products, // Correct type
      "total": total,
      "note": note,
      "phone": phone
    };

    var response = await http.post(
      Uri.parse('$kEndpoint/order/createOrder'),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      log(json.toString());
      return Order.fromJson(json["data"] as Map<String, dynamic>);
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      log(json.toString());
      String errorMessage = json["message"];
      throw errorMessage;
    } else if (response.statusCode == 401) {
      final json = jsonDecode(response.body);
      log(json.toString());
      String errorMessage = json["message"];
      throw errorMessage;
    } else {
      final json = jsonDecode(response.body);
      log(json.toString());
      String errorMessage = json["message"];
      throw errorMessage;
    }
  }
}
