import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Category.dart';

class CategoryServices {
  Future<List<Category>> fetchCategory() async {
    var response = await http.get(
      Uri.parse('$kEndpoint/category/getAllCategories'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());

      // Check if 'categories' key exists and is not null
      if (json.containsKey("categories") && json["categories"] != null) {
        List<dynamic> categoriesJson = json["categories"];
        return categoriesJson.map((json) => Category.fromJson(json)).toList();
      } else {
        // Return an empty list if 'categories' key is missing or null
        return [];
      }
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
