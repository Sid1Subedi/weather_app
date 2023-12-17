import 'dart:convert';
import 'package:weather_app/constants/global_constants.dart';

class SettingsModel {
  String temperatureMeasurementUnit;
  String language;
  String defaultCity;

  SettingsModel({
    required this.temperatureMeasurementUnit,
    required this.language,
    required this.defaultCity,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      temperatureMeasurementUnit: json['temperatureMeasurementUnit'] ??
          GlobalConstants.temperatureMetricsForWeatherAPICall,
      language: json['language'] ?? 'en',
      defaultCity: json['defaultCity'] ?? GlobalConstants.kDefaultCityName,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temperatureMeasurementUnit'] = temperatureMeasurementUnit;
    data['language'] = language;
    data['defaultCity'] = defaultCity;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
