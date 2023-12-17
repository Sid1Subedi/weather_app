import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/all_providers_export.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/scaffold_widget/scaffold_widget.dart';
import 'package:weather_app/src/weather_home_page/models/weather_forecast_response_model.dart';

class WeatherForecastSinglePage extends StatefulWidget {
  final List<WeatherForecastData>? weatherDataList;
  final String day;

  const WeatherForecastSinglePage({
    super.key,
    required this.weatherDataList,
    required this.day,
  });

  @override
  State<WeatherForecastSinglePage> createState() =>
      _WeatherForecastSinglePageState();
}

class _WeatherForecastSinglePageState extends State<WeatherForecastSinglePage> {
  late final WeatherHomeProvider _weatherHomeProvider;

  @override
  void initState() {
    super.initState();

    _weatherHomeProvider = Provider.of<WeatherHomeProvider>(
      context,
      listen: false,
    );

    //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _weatherHomeProvider.requestChangeWeatherForecastSelectedData(
        index: 0,
        weatherForecastData: widget.weatherDataList?[0],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      showBackBtn: true,
      body: Consumer<WeatherHomeProvider>(
        builder: (context, weatherHomeProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(
                  weatherHomeProvider: weatherHomeProvider,
                ),
                _buildTemperatureDetails(
                  weatherHomeProvider: weatherHomeProvider,
                ),
                _buildTemperatureInterval(
                  weatherHomeProvider: weatherHomeProvider,
                ),
                _buildWeatherDescription(
                  weatherHomeProvider: weatherHomeProvider,
                ),
              ],
            ),
          );
        },
      ),
      appBarTitle: widget.day,
    );
  }

  Widget _buildHeader({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
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
                  '${_weatherHomeProvider.currentWeatherResponseModel?.name} - ${_weatherHomeProvider.currentWeatherResponseModel?.sys?.country}',
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

  Widget _buildTemperatureInterval({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.16,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataList?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              weatherHomeProvider.requestChangeWeatherForecastSelectedData(
                weatherForecastData: widget.weatherDataList?[index],
                index: index,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    GlobalConstants().dateTimeToTimeFormat(
                        widget.weatherDataList?[index].dtTxt),
                    style: const TextStyle(
                      color: AppColorConstants.whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: GlobalConstants.kConstHeight),
                  CachedNetworkImage(
                    imageUrl: GlobalConstants().getUrlForWeatherIconImage(
                      icon:
                          '${widget.weatherDataList?[index].weather?[0].icon}',
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    height: 36,
                    width: 36,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  SizedBox(height: GlobalConstants.kConstHeight),
                  Text(
                    "${widget.weatherDataList?[index].main?.temp} ${GlobalConstants.getTemperatureUnitSymbol()}",
                    style: const TextStyle(
                      color: AppColorConstants.whiteColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: GlobalConstants.kConstWidth,
                    height: 1,
                    color: index ==
                            weatherHomeProvider.selectedWeatherForecastIndex
                        ? AppColorConstants.whiteColor
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemperatureIcon({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return CachedNetworkImage(
      imageUrl: GlobalConstants().getUrlForWeatherIconImage(
        icon:
            '${weatherHomeProvider.weatherForecastDataModel?.weather?[0].icon}',
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

  Widget _buildTemperatureDetails({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${weatherHomeProvider.weatherForecastDataModel?.main?.temp}${GlobalConstants.getTemperatureUnitSymbol()}',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            '${'Feels'.tr()} ${'Like'.tr()} ${weatherHomeProvider.weatherForecastDataModel?.main?.feelsLike}\u00B0',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'H:${weatherHomeProvider.weatherForecastDataModel?.main?.tempMin}\u00B0 L:${weatherHomeProvider.weatherForecastDataModel?.main?.tempMax}\u00B0',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDescription({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildWeatherAndCloudWidget(
            weatherHomeProvider: weatherHomeProvider,
          ),
          SizedBox(
            height: GlobalConstants.kConstHeight,
          ),
          _buildWindsWidget(
            weatherHomeProvider: weatherHomeProvider,
          ),
          SizedBox(
            height: GlobalConstants.kConstHeight,
          ),
          _buildVisibilityAndHumidityWidget(
            weatherHomeProvider: weatherHomeProvider,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherAndCloudWidget({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    // Weather and Clouds
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Weather Icon
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
                _buildTemperatureIcon(
                  weatherHomeProvider: weatherHomeProvider,
                ),
                Text(
                  weatherHomeProvider
                          .weatherForecastDataModel?.weather?[0].main ??
                      'N/A',
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
                  cloudCoverage:
                      weatherHomeProvider.weatherForecastDataModel?.clouds?.all,
                  cloudDescription: weatherHomeProvider
                      .weatherForecastDataModel?.weather?[0].description,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildWindsWidget({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    // Winds
    return Container(
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
                        '${weatherHomeProvider.weatherForecastDataModel?.wind?.speed}',
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
            angle: ((weatherHomeProvider.weatherForecastDataModel?.wind?.deg ??
                        0) -
                    45) *
                (3.14159265359 / 180),
            child: const Icon(
              Icons.assistant_navigation,
              size: 63.0,
              color: AppColorConstants.whiteColor, // Adjust color as needed
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityAndHumidityWidget({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    // Visibility And Humidity
    return Row(
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
                  GlobalConstants().convertVisibility(
                      weatherHomeProvider.weatherForecastDataModel?.visibility),
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
              borderRadius: BorderRadius.circular(16.0),
            ),
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
                  "${weatherHomeProvider.weatherForecastDataModel?.main?.humidity}%",
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
