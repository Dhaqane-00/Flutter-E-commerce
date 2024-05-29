import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

class ProductServices {
  Future<List<Product>> fetchProducts() async {
    var response = await http.get(
      Uri.parse('$kEndpoint/product/getAllProducts'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      print("Product Data");
      final json = jsonDecode(response.body);
      log(json.toString());
      List<dynamic> productsJson = json["Date"];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
