import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/all_providers_export.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/dropdown_widgets/city_names_dropdown_widget.dart';
import 'package:weather_app/custom_widgets/loading_indicator_widget/shimmer_effect_skeleton_widget.dart';
import 'package:weather_app/custom_widgets/scaffold_widget/scaffold_widget.dart';
import 'package:weather_app/services/navigation_services/routing_services.dart';
import 'package:weather_app/src/weather_home_page/models/weather_forecast_response_model.dart';
import 'package:weather_app/src/weather_home_page/providers/weather_home_provider.dart';
import 'package:weather_app/src/weather_home_page/views/current_weather_page_view.dart';
import 'package:weather_app/src/weather_home_page/views/weather_forecast_single_view.dart';

class WeatherHomePageView extends StatefulWidget {
  const WeatherHomePageView({super.key});

  @override
  State<WeatherHomePageView> createState() => _WeatherHomePageViewState();
}

class _WeatherHomePageViewState extends State<WeatherHomePageView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
      _getCurrentWeatherData();
    });
  }

  _getCurrentWeatherData() async {
    await _weatherHomeProvider.requestGetWeatherData();
    await _weatherHomeProvider.requestGetForecastWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    // For AutomaticKeepAliveClientMixin
    super.build(context);
    return ScaffoldWidget(
      body: Consumer<WeatherHomeProvider>(
        builder: (context, weatherHomeProvider, child) {
          if (weatherHomeProvider.isLoadingCurrentWeather) {
            return ShimmerEffectSkeleton(
              child: Column(
                children: [
                  Expanded(
                    child: _currentWeatherBody(
                      weatherHomeProvider: weatherHomeProvider,
                    ),
                  ),
                ],
              ),
            );
          }
          return _weatherHomeBody(
            weatherHomeProvider: weatherHomeProvider,
          );
        },
      ),
      appBarTitle: 'Sky Weather View',
    );
  }

  Widget _weatherHomeBody({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _currentWeatherBody(
            weatherHomeProvider: weatherHomeProvider,
          ),
          _forecastBody(
            weatherHomeProvider: weatherHomeProvider,
          ),
        ],
      ),
    );
  }

  Widget _currentWeatherBody({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    return GestureDetector(
      onTap: () {
        if (!weatherHomeProvider.isLoadingCurrentWeather) {
          NavigationRoutingServices().navigateToRoute(
            context: context,
            child: CurrentWeatherDetailPage(
              weatherData: weatherHomeProvider.currentWeatherResponseModel,
            ),
          );
        }
      },
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
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // First Row - Search Bar
            Row(
              children: [
                Expanded(
                  child: CityNamesDropDownWidget(
                    selectedItem: GlobalConstants.cityNameForWeatherAPICall,
                    isEnabled: true,
                    labelText: 'City'.tr(),
                    onCityNameSelected: (value) {
                      GlobalConstants.cityNameForWeatherAPICall =
                          value ?? GlobalConstants.kDefaultCityName;

                      // Get The New Data For Weather
                      _getCurrentWeatherData();
                    },
                  ),
                ),
              ],
            ),
            // Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${_weatherHomeProvider.currentWeatherResponseModel?.main?.temp}${GlobalConstants.getTemperatureUnitSymbol()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            // Last Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: GlobalConstants().getUrlForWeatherIconImage(
                        icon:
                            '${weatherHomeProvider.currentWeatherResponseModel?.weather?[0].icon}',
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      height: 100,
                      width: 100,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${'Feels'.tr()} ${'Like'.tr()} ${weatherHomeProvider.currentWeatherResponseModel?.main?.feelsLike}\u00B0",
                      style: const TextStyle(
                        color: AppColorConstants.whiteColor,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: GlobalConstants.kConstHeight / 2,
                    ),
                    Text(
                      'H:${_weatherHomeProvider.currentWeatherResponseModel?.main?.tempMin}\u00B0  L:${_weatherHomeProvider.currentWeatherResponseModel?.main?.tempMax}\u00B0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _forecastBody({
    required WeatherHomeProvider weatherHomeProvider,
  }) {
    var groupedWeatherForecastData = _groupForecastDataByDay(
      weatherForecastResponseModel:
          weatherHomeProvider.weatherForecastResponseModel,
    );
    // Container to display weather for the next five days - including Today
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColorConstants.pageBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${'Next'.tr()} 5 ${'Days'.tr()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // Use ListView.builder
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupedWeatherForecastData?.length ?? 0,
            itemBuilder: (context, index) {
              return buildWeatherContainer(
                groupedWeatherForecastData: groupedWeatherForecastData,
                index: index,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16);
            },
          ),
        ],
      ),
    );
  }

  Widget buildWeatherContainer({
    required Map<String, List<WeatherForecastData>?>?
        groupedWeatherForecastData,
    required int index,
  }) {
    // Extract list of weather data for the current date
    List<WeatherForecastData>? weatherDataList = groupedWeatherForecastData?[
        groupedWeatherForecastData.keys.elementAt(index)];

    if (weatherDataList != null && weatherDataList.isNotEmpty) {
      WeatherForecastData? weatherData = weatherDataList.firstWhere(
        (data) => data.dtTxt != null && data.dtTxt!.endsWith("12:00:00"),
        orElse: () {
          // Find the nearest item to "12:00:00" if no exact match
          return weatherDataList.reduce((a, b) {
            DateTime aTime = DateTime.parse(a.dtTxt!);
            DateTime bTime = DateTime.parse(b.dtTxt!);
            DateTime noon =
                DateTime(aTime.year, aTime.month, aTime.day, 12, 0, 0);

            return (aTime
                        .difference(noon)
                        .abs()
                        .compareTo(bTime.difference(noon).abs()) <=
                    0)
                ? a
                : b;
          });
        },
      );

      var day = GlobalConstants().dateTimeToDay(
        weatherData.dtTxt,
      );

      var date = GlobalConstants().dateTimeToDateMonthFormat(weatherData.dtTxt);
      var minTemp = weatherData.main?.tempMin;
      var maxTemp = weatherData.main?.tempMax;
      var iconData = weatherData.weather?[0].icon;

      return GestureDetector(
        onTap: () {
          if (!_weatherHomeProvider.isLoadingCurrentWeather) {
            NavigationRoutingServices().navigateToRoute(
              context: context,
              child: WeatherForecastSinglePage(
                day: day,
                weatherDataList: weatherDataList,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                day != 'Today' ? Colors.purple : Colors.blue.shade800,
                day != 'Today' ? Colors.blue : Colors.blue.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First Column - Day and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Second Column - Min/Max Temperature
              Text(
                '$minTemp ${GlobalConstants.getTemperatureUnitSymbol()} / $maxTemp ${GlobalConstants.getTemperatureUnitSymbol()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              // Third Column - Weather Icon
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Colors.transparent, // You can change this color if needed
                ),
                child: CachedNetworkImage(
                  imageUrl: GlobalConstants().getUrlForWeatherIconImage(
                    icon: '$iconData',
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  height: 100,
                  width: 100,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Map<String, List<WeatherForecastData>?>? _groupForecastDataByDay({
    required WeatherForecastResponseModel? weatherForecastResponseModel,
  }) {
    // Check if weatherForecastResponseModel is not null
    if (weatherForecastResponseModel != null) {
      // Group the weather data by day
      Map<String, List<WeatherForecastData>?> groupedWeatherForecastData = {};

      for (var data in weatherForecastResponseModel.list ?? []) {
        // Check if data is not null
        if (data != null) {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(data.dt * 1000, isUtc: true);
          String day = DateFormat('yyyy-MM-dd').format(dateTime);

          groupedWeatherForecastData.putIfAbsent(day, () => []);
          groupedWeatherForecastData[day]!.add(data);
        }
      }

      return groupedWeatherForecastData;
    }

    return null;
  }
}
