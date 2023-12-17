import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/internet_services/internet_connection_check_services.dart';

class HttpServices {
  // Right Now we are only using GET
  Future<dynamic> httpGet({
    required String url,
    bool showRequestLog = false,
    bool showResponseLog = false,
  }) async {
    try {
      // Check Internet Connection and if no internet connection return null
      if (!await InternetConnectionCheckServices.isInternetAvailable()) {
        return null;
      }

      final client = http.Client();

      if (showRequestLog) {
        debugPrint("Url: $url");
      }

      final httpResponse = await client.get(Uri.parse(url));

      client.close();

      if (showResponseLog) {
        debugPrint("httpResponse GET: ${httpResponse.body}");
      }
      return json.decode(httpResponse.body);
    } catch (ex) {
      if (showResponseLog) {
        debugPrint("Something went wrong GET: $ex");
      }
      return "Failed";
    }
  }
}
