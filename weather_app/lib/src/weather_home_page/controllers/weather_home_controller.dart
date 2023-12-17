import 'package:flutter/material.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/toast_message_widget/toast_message_widget.dart';
import 'package:weather_app/services/internet_services/http_services.dart';
import 'package:weather_app/src/weather_home_page/models/current_weather_response_model.dart';
import 'package:weather_app/src/weather_home_page/models/weather_forecast_response_model.dart';

class WeatherHomeController {
  HttpServices httpServices = HttpServices();

  Future<CurrentWeatherResponseModel?> getCurrentWeatherData() async {
    try {
      var key = GlobalConstants.getCurrentWeatherActionKey;

      String url = GlobalConstants().getRequestURL(
        keyWithCallMethod: key,
      );

      var response = await httpServices.httpGet(
        url: url,
      );

      if (response == null) {
        ToastMessages().showErrorToastMessage(
          message: GlobalConstants.noInternetConnectionMessage,
        );
        return null;
      }

      CurrentWeatherResponseModel currentWeatherResponse =
          CurrentWeatherResponseModel.fromJson(response);

      if (currentWeatherResponse.cod !=
          GlobalConstants.errorCodeSuccessReceived) {
        ToastMessages().showErrorToastMessage(
          message: currentWeatherResponse.message ??
              GlobalConstants.globalExceptionMessage,
        );
        return null;
      }
      return currentWeatherResponse;
    } catch (ex) {
      debugPrint("Current Weather Data Get Error: $ex");
      ToastMessages().showErrorToastMessage(
        message: GlobalConstants.globalExceptionMessage,
      );
      return null;
    }
  }

  Future<WeatherForecastResponseModel?> getForecastWeatherData() async {
    try {
      var key = GlobalConstants.getForecastWeatherActionKey;

      String url = GlobalConstants().getRequestURL(
        keyWithCallMethod: key,
      );

      var response = await httpServices.httpGet(
        url: url,
      );

      if (response == null) {
        ToastMessages().showErrorToastMessage(
          message: GlobalConstants.noInternetConnectionMessage,
        );
        return null;
      }

      WeatherForecastResponseModel weatherForecastResponseModel =
      WeatherForecastResponseModel.fromJson(response);

      if (weatherForecastResponseModel.cod !=
          GlobalConstants.errorCodeSuccessReceived) {
        ToastMessages().showErrorToastMessage(
          message: weatherForecastResponseModel.message ??
              GlobalConstants.globalExceptionMessage,
        );
        return null;
      }
      return weatherForecastResponseModel;
    } catch (ex) {
      debugPrint("Weather Forecast Data Get Error: $ex");
      ToastMessages().showErrorToastMessage(
        message: GlobalConstants.globalExceptionMessage,
      );
      return null;
    }
  }
}
