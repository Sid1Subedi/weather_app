import 'package:flutter/material.dart';
import 'package:weather_app/src/weather_home_page/controllers/weather_home_controller.dart';
import 'package:weather_app/src/weather_home_page/models/current_weather_response_model.dart';
import 'package:weather_app/src/weather_home_page/models/weather_forecast_response_model.dart';

class WeatherHomeProvider extends ChangeNotifier {
  bool isLoadingCurrentWeather = true;

  CurrentWeatherResponseModel? currentWeatherResponseModel;
  WeatherForecastResponseModel? weatherForecastResponseModel;

  WeatherForecastData? weatherForecastDataModel;

  int selectedWeatherForecastIndex = 0;

  requestGetWeatherData() async {
    isLoadingCurrentWeather = true;
    //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // To Show Loading Shimmer
      notifyListeners();
    });
    currentWeatherResponseModel = null;

    var response = await WeatherHomeController().getCurrentWeatherData();

    if (response != null) {
      currentWeatherResponseModel = response;
    }

    // isLoadingCurrentWeather = false;

    //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  requestGetForecastWeatherData() async {
    isLoadingCurrentWeather = true;
    //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // To Show Loading Shimmer
      notifyListeners();
    });

    weatherForecastResponseModel = null;

    var response = await WeatherHomeController().getForecastWeatherData();

    if (response != null) {
      weatherForecastResponseModel = response;
    }

    isLoadingCurrentWeather = false;

    //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  requestChangeWeatherForecastSelectedData({
    required WeatherForecastData? weatherForecastData,
    required int index,
  }) {
    weatherForecastDataModel = weatherForecastData;
    selectedWeatherForecastIndex = index;

    notifyListeners();
  }
}
