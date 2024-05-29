import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/models/Order.dart'; // Added import
import 'package:shop_app/models/Product.dart';
import '../models/user.dart';

class OrderServices {
  Future<Order> order({
    required String user,
    required String payment,
    required List<Product> products, // Corrected parameter type
    required double total,
    required String note,
    required String phone,
  }) async {
    var data = {
      "user": user,
      "payment": payment,
      "products": products.map((product) => product.toJson()).toList(),
      "total": total,
      "note": note,
      "phone": phone
    };

    var response = await http.post(
      Uri.parse('$kEndpoint/order/createOrder'),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());
      return Order.fromJson(json["data"]);
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
