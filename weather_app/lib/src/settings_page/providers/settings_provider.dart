import 'package:flutter/material.dart';
import 'package:weather_app/constants/global_constants.dart';

class SettingsProvider extends ChangeNotifier {
  String temperatureMetricsSelectedValue = GlobalConstants.temperatureMetricsForWeatherAPICall;
  String appLanguageSelectedValue = GlobalConstants.appLanguageForWeatherAPICall;
  String defaultCityValue = GlobalConstants.kDefaultCityName;

  bool canEditSettingsValue = false;

  requestResetSettingsValues() {
    temperatureMetricsSelectedValue =
        GlobalConstants.temperatureMetricsForWeatherAPICall;
    appLanguageSelectedValue = GlobalConstants.appLanguageForWeatherAPICall;
    defaultCityValue = GlobalConstants.kDefaultCityName;

    // Make Edit Disabled
    canEditSettingsValue = false;

    notifyListeners();
  }

  requestEditSettingsValue() {
    canEditSettingsValue = true;

    notifyListeners();
  }
}
