import 'dart:io';
import 'package:http/http.dart' as http;

class InternetConnectionCheckServices {
  static Future<bool> isInternetAvailable() async {
    return await _checkInternetConnection();
  }

  static Future<bool> _checkInternetConnection() async {
    try {
      final client = http.Client();

      final response = await client.get(
        Uri.parse("https://google.com"),
      );

      client.close();

      if (response.statusCode == HttpStatus.ok) {
        return true; // Internet connection is available
      } else {
        return false; // No internet connection
      }
    } catch (e) {
      return false; // No internet connection
    }
  }
}
