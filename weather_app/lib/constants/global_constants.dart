import 'package:easy_localization/easy_localization.dart';
import 'package:weather_app/constants/all_enum_constants.dart';

class GlobalConstants {
  static late final String openWeatherServerAddress;
  static late final String openWeatherAPIKey;
  static const String weatherRequest = "data/2.5";
  static const String geoEncodingRequest = "geo/1.0";

  // Encryption Constants - Hive
  static late final String kSecureBoxName;
  static late final String kAppDetailsStorageKey;

  // API Action Keys
  static String getCurrentWeatherActionKey = "weather";
  static String getForecastWeatherActionKey = "forecast";

  String getRequestURL({
    required String keyWithCallMethod,
  }) {
    //https://api.openweathermap.org/data/2.5/weather?lat=10.000&lon=100.000&units=Metric&lang=en&appid=apple

    String appIdParam = "?appId=$openWeatherAPIKey";
    String cityName = "&q=$cityNameForWeatherAPICall";
    String unitParam = "&units=$temperatureMetricsForWeatherAPICall";
    String langParam = "&lang=$appLanguageForWeatherAPICall";

    return "$openWeatherServerAddress/$weatherRequest/$keyWithCallMethod$appIdParam$cityName$unitParam$langParam";
  }

  String getUrlForWeatherIconImage({
    required String icon,
  }) {
    //https://openweathermap.org/img/wn/10d@4x.png
    return "https://openweathermap.org/img/wn/$icon@4x.png";
  }

  static String getTemperatureUnitSymbol() {
    if (temperatureMetricsForWeatherAPICall ==
        TemperatureUnitEnum.metric.toTemperatureUnitString()) {
      return "\u2103"; // C
    } else if (temperatureMetricsForWeatherAPICall ==
        TemperatureUnitEnum.imperial.toTemperatureUnitString()) {
      return "\u2109"; // F
    }
    return "\u212A"; // K
  }

  // region DateTime Constants

  String unixTimeToFormattedTime(int? unixTime, int? timeZoneOffsetInSeconds) {
    try {
      if (unixTime == null || timeZoneOffsetInSeconds == null) {
        return "N/A";
      }

      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        unixTime * 1000,
        isUtc: false,
      );

      int currentTimeZoneOffsetInSeconds = dateTime.timeZoneOffset.inSeconds;

      int totalTimeToAddInSeconds =
          timeZoneOffsetInSeconds - currentTimeZoneOffsetInSeconds;

      DateTime adjustedDateTime =
          dateTime.add(Duration(seconds: totalTimeToAddInSeconds));

      String formattedTime = DateFormat('hh:mm a').format(adjustedDateTime);

      return formattedTime;
    } catch (ex) {
      return "N/A";
    }
  }

  String dateTimeToDay(
    String? dateTimeString,
  ) {
    try {
      if (dateTimeString == null) {
        return "N/A";
      }

      DateTime parsedDateTime = DateTime.parse(dateTimeString);

      DateTime today = DateTime.now();
      today = DateTime(today.year, today.month, today.day);

      bool isToday = parsedDateTime.year == today.year &&
          parsedDateTime.month == today.month &&
          parsedDateTime.day == today.day;

      if (isToday) {
        return "Today";
      }

      String formattedTime = DateFormat('EEEE').format(parsedDateTime);

      return formattedTime;
    } catch (ex) {
      return "N/A";
    }
  }

  String dateTimeToDateMonthFormat(
    String? dateTimeString,
  ) {
    try {
      if (dateTimeString == null || dateTimeString.isEmpty) {
        return "N/A";
      }

      DateTime dateTime = DateTime.parse(dateTimeString);

      String formattedDate = DateFormat('dd MMMM').format(dateTime);

      return formattedDate;
    } catch (ex) {
      return "N/A";
    }
  }

  String dateTimeToTimeFormat(String? dateTimeString) {
    if (dateTimeString == null) {
      return "N/A";
    }

    try {
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat.jm().format(dateTime);
    } catch (e) {
      return "N/A";
    }
  }

  //endregion

  String convertVisibility(int? visibilityInInt) {
    if (visibilityInInt == null) {
      return "N/A";
    }

    bool isMetric =
        temperatureMetricsForWeatherAPICall.toLowerCase() == 'metric';
    int visibilityInUnit =
        isMetric ? visibilityInInt ~/ 1000 : visibilityInInt ~/ 1609;

    String unitLabel = isMetric ? 'km' : 'mi';
    return '$visibilityInUnit $unitLabel';
  }

  String getWindSpeedAndGustUnit() {
    bool isMetric = GlobalConstants.temperatureMetricsForWeatherAPICall ==
        TemperatureUnitEnum.metric.toTemperatureUnitString();

    return isMetric ? 'm/s' : 'mph';
  }

  String capitalizeString(String? inputString) {
    if (inputString == null || inputString.isEmpty) {
      return "";
    }
    return inputString.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  // region App Constant Messages

  static const String errorCodeSuccessReceived = "200";
  static const String globalExceptionMessage =
      "Something Went Wrong. Please Try Again Later!";
  static const String noInternetConnectionMessage = "No Internet Connection";
  static const String locationPermissionNotGrantedMessage =
      "Location Permission Not Granted";
  static const String backgroundLocationPermissionNotGrantedMessage =
      "Background Location Permission Not Granted";

  //endregion

  //Default Values
  static double kConstWidth = 25.0;
  static double kConstHeight = 10.0;
  static double kHeadingTitleFontSize = 18.0;
  static String kDefaultCityName = "Dubai";

  // Weather API Call Constants - App Locale/Lang, temp units
  static String appLanguageForWeatherAPICall =
      LanguageEnum.english.toLanguageString();
  // Default For Dubai
  static String cityNameForWeatherAPICall = kDefaultCityName;
  static String temperatureMetricsForWeatherAPICall =
      TemperatureUnitEnum.metric.toTemperatureUnitString();
}
