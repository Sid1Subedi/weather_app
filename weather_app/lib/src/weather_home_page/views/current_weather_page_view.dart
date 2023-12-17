import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/scaffold_widget/scaffold_widget.dart';
import 'package:weather_app/src/weather_home_page/models/current_weather_response_model.dart';

class CurrentWeatherDetailPage extends StatelessWidget {
  final CurrentWeatherResponseModel? weatherData;

  const CurrentWeatherDetailPage({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      showBackBtn: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTemperatureSection(),
            _buildWeatherDescription(context),
          ],
        ),
      ),
      appBarTitle: 'Current Weather Details',
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.purple,
            Colors.blue.shade800,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColorConstants.whiteColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  '${weatherData?.name} - ${weatherData?.sys?.country}',
                  style: const TextStyle(
                    color: AppColorConstants.whiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: _buildTemperatureDetails(),
    );
  }

  Widget _buildTemperatureIcon() {
    return CachedNetworkImage(
      imageUrl: GlobalConstants().getUrlForWeatherIconImage(
        icon: '${weatherData?.weather?[0].icon}',
      ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      height: 100,
      width: 100,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildTemperatureDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${weatherData?.main?.temp}${GlobalConstants.getTemperatureUnitSymbol()}',
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          '${'Feels'.tr()} ${'Like'.tr()} ${weatherData?.main?.feelsLike}\u00B0',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'H:${weatherData?.main?.tempMin}\u00B0 L:${weatherData?.main?.tempMax}\u00B0',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Weather and Clouds
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // WEATHER ICON
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.21,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.purple,
                          Colors.blue.shade800,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTemperatureIcon(),
                      Text(
                        weatherData?.weather?[0].main ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: AppColorConstants.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: GlobalConstants.kConstWidth / 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.21,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue.shade800, Colors.blue.shade400],
                      ),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _cloudCoverage(
                        cloudCoverage: weatherData?.clouds?.all,
                        cloudDescription: weatherData?.weather?[0].description,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: GlobalConstants.kConstHeight,
          ),
          // Sunrise And Sunset
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0)),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: AppColorConstants.whiteColor,
                        ),
                        SizedBox(
                          width: GlobalConstants.kConstWidth / 4,
                        ),
                        Text(
                          "Sunrise".tr().toUpperCase(),
                          style: const TextStyle(
                            color: AppColorConstants.whiteColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: GlobalConstants.kConstHeight,
                    ),
                    Text(
                      GlobalConstants().unixTimeToFormattedTime(
                        weatherData?.sys?.sunrise,
                        weatherData?.timezone,
                      ),
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: AppColorConstants.whiteColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.dark_mode,
                          color: AppColorConstants.whiteColor,
                        ),
                        SizedBox(
                          width: GlobalConstants.kConstWidth / 4,
                        ),
                        Text(
                          "Sunset".tr().toUpperCase(),
                          style: const TextStyle(
                            color: AppColorConstants.whiteColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: GlobalConstants.kConstHeight,
                    ),
                    Text(
                      GlobalConstants().unixTimeToFormattedTime(
                        weatherData?.sys?.sunset,
                        weatherData?.timezone,
                      ),
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: AppColorConstants.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: GlobalConstants.kConstHeight,
          ),
          // Visibility And Humidity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.purple,
                          Colors.blue.shade800,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColorConstants.whiteColor,
                          ),
                          SizedBox(
                            width: GlobalConstants.kConstWidth / 4,
                          ),
                          Text(
                            "Visibility".tr().toUpperCase(),
                            style: const TextStyle(
                              color: AppColorConstants.whiteColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: GlobalConstants.kConstHeight,
                      ),
                      Text(
                        GlobalConstants()
                            .convertVisibility(weatherData?.visibility),
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: AppColorConstants.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: GlobalConstants.kConstWidth / 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue.shade800,
                          Colors.blue.shade400,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.waves,
                            color: AppColorConstants.whiteColor,
                          ),
                          SizedBox(
                            width: GlobalConstants.kConstWidth / 4,
                          ),
                          Text(
                            "Humidity".tr().toUpperCase(),
                            style: const TextStyle(
                              color: AppColorConstants.whiteColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: GlobalConstants.kConstHeight,
                      ),
                      Text(
                        "${weatherData?.main?.humidity}%",
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: AppColorConstants.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: GlobalConstants.kConstHeight,
          ),
          // Winds
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.purple,
                    Colors.blue,
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0)),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.air_outlined,
                              color: AppColorConstants.whiteColor,
                            ),
                            SizedBox(
                              width: GlobalConstants.kConstWidth / 4,
                            ),
                            Text(
                              "Winds".tr().toUpperCase(),
                              style: const TextStyle(
                                color: AppColorConstants.whiteColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: GlobalConstants.kConstHeight / 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${weatherData?.wind?.speed}',
                              style: const TextStyle(
                                fontSize: 30.0,
                                color: AppColorConstants.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: GlobalConstants.kConstWidth / 2,
                            ),
                            Text(
                              GlobalConstants().getWindSpeedAndGustUnit(),
                              style: const TextStyle(
                                color: AppColorConstants.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Transform.rotate(
                  angle: ((weatherData?.wind?.deg ?? 0) - 45) *
                      (3.14159265359 / 180),
                  child: const Icon(
                    Icons.assistant_navigation,
                    size: 63.0,
                    color:
                        AppColorConstants.whiteColor, // Adjust color as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cloudCoverage({
    required int? cloudCoverage,
    required String? cloudDescription,
  }) {
    IconData iconData;
    Color iconColor = Colors.blue.shade50;

    if (cloudCoverage == null || cloudCoverage == 0) {
      iconData = Icons.cloud_off;
    } else if (cloudCoverage > 0 && cloudCoverage <= 30) {
      iconData = Icons.cloud_queue;
    } else if (cloudCoverage > 30 && cloudCoverage <= 70) {
      iconData = Icons.cloud;
    } else {
      iconData = Icons.cloud_rounded;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: GlobalConstants.kConstHeight,
        ),
        Icon(
            iconData,
            size: 80,
          color: iconColor,
        ),
        SizedBox(
            height: GlobalConstants.kConstHeight,
        ),
        Text(
          GlobalConstants().capitalizeString(cloudDescription),
          style: const TextStyle(
            fontSize: 18.0,
            color: AppColorConstants.whiteColor,
          ),
        ),
      ],
    );
  }
}
