import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppConfig {
  //For Backend Server
  static late final String openWeatherServerAddress;
  static late final String openWeatherAPIKey;

  // For App Encryption Services - Hive
  static late final String kSecureBoxName;
  static late final String kAppDetailsStorageKey;

  static Future<void> load() async {
    try {
      final config = await rootBundle.loadString('config.yaml');
      final yaml = loadYaml(config);

      //For Backend Server
      openWeatherServerAddress = yaml['openWeatherServerAddress'];
      openWeatherAPIKey = yaml['openWeatherAPIKey'];

      //For App Encryption Services - Hive
      kSecureBoxName = yaml['kSecureBoxName'];
      kAppDetailsStorageKey = yaml['kAppDetailsStorageKey'];

    } catch (e) {
      // Handle any errors that occur during configuration loading
      debugPrint('Error loading configuration: $e');
    }
  }
}
