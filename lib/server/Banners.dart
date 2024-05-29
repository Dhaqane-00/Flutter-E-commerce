import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Banners.dart';

class BannersServices {
  Future<List<Banners>> fetchBanners() async {
    var response = await http.get(
      Uri.parse('$kEndpoint/banner/getAllBanners'),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    if (response.statusCode == 200) {
      print("Banners Data");
      final json = jsonDecode(response.body);
      log('Response JSON: $json'); // Log the entire response

      // Ensure the key exists and is not null
      if (json.containsKey("banners") && json["banners"] != null) {
        List<dynamic> bannersJson = json["banners"];
        log('Parsed banners: $bannersJson');
        return bannersJson.map((json) => Banners.fromJson(json)).toList();
      } else {
        log('No banners available in the response');
        throw "No banners available";
      }
    } else {
      final json = jsonDecode(response.body);
      String errorMessage = json["message"] ?? "An unknown error occurred";
      log('Error response: $errorMessage');
      throw errorMessage;
    }
  }
}
