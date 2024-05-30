import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Title.dart';

class TitleServices {
  Future<List<NewTitle>> fetchTitle() async {
    var response = await http.get(
      Uri.parse('$kEndpoint/title/getAllTitles'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      log(json.toString());

      // Check if the 'titles' key exists and contains data
      if (json.containsKey("titles") && json["titles"] is List) {
        // Parse the list of titles
        List<dynamic> titlesJson = json["titles"];
        return titlesJson.map((json) => NewTitle.fromJson(json)).toList();
      } else {
        // Return an empty list if no titles found
        return [];
      }
    } else {
      // Handle API error response
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      throw errorMessage;
    }
  }
}
