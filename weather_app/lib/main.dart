import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/app_config.dart';
import 'package:weather_app/constants/all_providers_export.dart';
import 'package:weather_app/constants/city_list_constants.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:weather_app/custom_widgets/loading_indicator_widget/loading_indicator_overlay.dart';
import 'package:weather_app/custom_widgets/toast_message_widget/toast_message_widget.dart';
import 'package:weather_app/services/encryption_services/hive_secure_storage_encryption_service.dart';
import 'package:weather_app/services/internet_services/location_services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/src/settings_page/models/settings_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding

  //Set preferred orientation to landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  // Load The Cities Data on Init
  await CityData.loadCityData();

  //region Load the configuration For Backend Server API and Key
  await AppConfig.load();

  // region Access the configuration values
  //For Backend Server API
  GlobalConstants.openWeatherServerAddress = AppConfig.openWeatherServerAddress;
  GlobalConstants.openWeatherAPIKey = AppConfig.openWeatherAPIKey;

  //For Encryption Services Constants - Hive

  GlobalConstants.kSecureBoxName = AppConfig.kSecureBoxName;
  GlobalConstants.kAppDetailsStorageKey = AppConfig.kAppDetailsStorageKey;

  //endregion

  // Initialize hive
  await Hive.initFlutter();

  //Make A Hive Secured Box
  await HiveSecureStorage.makeSecureStorage(
    GlobalConstants.kAppDetailsStorageKey,
    GlobalConstants.kSecureBoxName,
  );

  // Load App Local Storage Values
  _getAppLocalStorage();

  //To Make Sure to Notify Only After the Widgets are build, so no setState or marksBuild error
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Request Required App Permissions
    await _checkAppPermissions();

    // Get User Current Location
    await LocationServices.getLocation();
  });

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AE'),
      ],
      path: 'assets/translations', // path to your translations files
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

Future<void> _checkAppPermissions() async {
  // Request foreground location permission
  Map<Permission, PermissionStatus> foregroundStatuses = await [
    Permission.locationWhenInUse,
  ].request();

  if (foregroundStatuses[Permission.locationWhenInUse]!.isGranted) {
    // Foreground location permission is granted, now request background location permission
    Map<Permission, PermissionStatus> backgroundStatuses = await [
      Permission.locationAlways,
    ].request();

    if (!backgroundStatuses[Permission.locationAlways]!.isGranted) {
      ToastMessages().showErrorToastMessage(
        message: GlobalConstants.backgroundLocationPermissionNotGrantedMessage,
      );
    }
  } else {
    ToastMessages().showErrorToastMessage(
      message: GlobalConstants.locationPermissionNotGrantedMessage,
    );
  }
}

void _getAppLocalStorage() {
  try {
    final hiveBox = HiveSecureStorage.getHiveBox();
    var settingsModelString = HiveSecureStorage.getInfo(
      hiveBox,
      GlobalConstants.kAppDetailsStorageKey,
    );

    if (settingsModelString != null) {
      SettingsModel settingsModelObj =
          SettingsModel.fromJson(json.decode(settingsModelString));

      // Set Data Accordingly To Settings Modal
      GlobalConstants.appLanguageForWeatherAPICall = settingsModelObj.language;
      GlobalConstants.temperatureMetricsForWeatherAPICall =
          settingsModelObj.temperatureMeasurementUnit;
      GlobalConstants.cityNameForWeatherAPICall =
          GlobalConstants.kDefaultCityName = settingsModelObj.defaultCity;
    }
  } catch (ex) {
    debugPrint("Something Went Wrong Getting Local Storage Data: $ex");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationServiceProvider>(
          create: (_) => NavigationServiceProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider<WeatherHomeProvider>(
          create: (_) => WeatherHomeProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Overlay(
          key: overlayKey,
          initialEntries: [
            OverlayEntry(
              builder: (BuildContext context) {
                return const MainPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomNavigationBarPage();
  }
}
