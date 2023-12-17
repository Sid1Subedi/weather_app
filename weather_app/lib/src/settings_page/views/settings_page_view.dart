import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/all_enum_constants.dart';
import 'package:weather_app/constants/all_providers_export.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/constants/global_constants.dart';
import 'package:weather_app/custom_widgets/custom_button_widgets/custom_cancel_elevated_button.dart';
import 'package:weather_app/custom_widgets/custom_button_widgets/custom_okay_elevated_button.dart';
import 'package:weather_app/custom_widgets/dropdown_widgets/city_names_dropdown_widget.dart';
import 'package:weather_app/custom_widgets/dropdown_widgets/custom_dropdown_widget.dart';
import 'package:weather_app/custom_widgets/loading_indicator_widget/loading_indicator_overlay.dart';
import 'package:weather_app/custom_widgets/scaffold_widget/scaffold_widget.dart';
import 'package:weather_app/services/encryption_services/hive_secure_storage_encryption_service.dart';
import 'package:weather_app/src/settings_page/models/settings_model.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: _settingsPageBody(
        context: context,
      ),
      appBarTitle: 'Settings',
    );
  }

  Widget _settingsPageBody({required BuildContext context}) {
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              CustomDropDownWidget(
                isEnabled: settingsProvider.canEditSettingsValue,
                dropDownTitle: 'Select Display Unit',
                selectedOption:
                    settingsProvider.temperatureMetricsSelectedValue,
                optionsForDropdown: [
                  TemperatureUnitEnum.metric.toTemperatureUnitString(),
                  TemperatureUnitEnum.imperial.toTemperatureUnitString(),
                ],
                onChanged: (value) {
                  setState(() {
                    settingsProvider.temperatureMetricsSelectedValue = value ??
                        GlobalConstants.temperatureMetricsForWeatherAPICall;
                  });
                },
              ),
              CustomDropDownWidget(
                isEnabled: settingsProvider.canEditSettingsValue,
                dropDownTitle: 'Select App Language',
                selectedOption: settingsProvider.appLanguageSelectedValue,
                optionsForDropdown: [
                  LanguageEnum.english.toLanguageString(),
                  LanguageEnum.arabic.toLanguageString(),
                ],
                onChanged: (value) {
                  setState(() {
                    settingsProvider.appLanguageSelectedValue =
                        value ?? LanguageEnum.english.toLanguageString();
                  });
                },
              ),
              CityNamesDropDownWidget(
                showLabelText: true,
                selectedItem: settingsProvider.defaultCityValue,
                isEnabled: settingsProvider.canEditSettingsValue,
                labelText: "${"Default".tr()} ${"City".tr()}",
                onCityNameSelected: (value) {
                  setState(() {
                    settingsProvider.defaultCityValue =
                        value ?? GlobalConstants.kDefaultCityName;
                  });
                },
              ),
              const Divider(height: 2),

              SizedBox(
                height: GlobalConstants.kConstHeight,
              ),

              // Edit Btn
              Visibility(
                visible: !settingsProvider.canEditSettingsValue,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.25,
                    right: MediaQuery.of(context).size.width * 0.25,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: CustomOkayElevatedButton(
                    btnText: 'Edit'.tr(),
                    onPressed: () {
                      settingsProvider.requestEditSettingsValue();
                    },
                  ),
                ),
              ),

              // Save Button
              Visibility(
                visible: settingsProvider.canEditSettingsValue,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.25,
                    right: MediaQuery.of(context).size.width * 0.25,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: CustomOkayElevatedButton(
                    btnText: 'Save'.tr(),
                    onPressed: () {
                      _saveSettingsChanges(
                        context: context,
                        settingsProvider: settingsProvider,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: GlobalConstants.kConstHeight,
              ),

              // Cancel Button
              Visibility(
                visible: settingsProvider.canEditSettingsValue,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.width * 0.25,
                    right: MediaQuery.of(context).size.width * 0.25,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: CustomCancelElevatedButton(
                    btnText: 'Cancel'.tr(),
                    onPressed: () {
                      // Reset Values After Saving/Disabled Edit
                      settingsProvider.requestResetSettingsValues();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 2),

        _aboutAppWidget,

        // Lower Section of Drawer
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
      ],
    );
  }

  Widget get _aboutAppWidget {
    return AboutListTile(
      icon: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColorConstants.purpleColor,
        ),
        child: const Icon(
          Icons.info,
          color: Colors.white,
        ),
      ),
      applicationIcon: const Icon(
        Icons.local_play,
        color: AppColorConstants.purpleColor,
      ),
      applicationName: 'Sky Weather View',
      applicationVersion: 'V1.08',
      applicationLegalese:
          '${String.fromCharCode(0x00A9)} ${DateTime.now().year} Bibek Subedi.',
      aboutBoxChildren: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColorConstants.purpleColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Weather App Made By Bibek Subedi",
            style: TextStyle(
              color: AppColorConstants.purpleColor,
            ),
          ),
        ),
      ],
      child: Text(
        'About App'.tr(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _getCurrentWeatherData(BuildContext context) async {
    await ShowOverlayLoadingIndicator.performTaskWithLoadingOverlay(
      () async {
        final weatherHomeProvider = Provider.of<WeatherHomeProvider>(
          context,
          listen: false,
        );
        await weatherHomeProvider.requestGetWeatherData();
        await weatherHomeProvider.requestGetForecastWeatherData();
      },
    );
  }

  void _changeLanguage({
    required BuildContext context,
    required SettingsProvider settingsProvider,
  }) {
    if (settingsProvider.appLanguageSelectedValue ==
        LanguageEnum.arabic.toLanguageString()) {
      GlobalConstants.appLanguageForWeatherAPICall =
          LanguageEnum.arabic.toLanguageString();
      EasyLocalization.of(context)?.setLocale(const Locale('ar', 'AE'));
    } else {
      GlobalConstants.appLanguageForWeatherAPICall =
          LanguageEnum.english.toLanguageString();
      EasyLocalization.of(context)?.setLocale(const Locale('en', 'US'));
    }
  }

  void _saveSettingsChanges({
    required BuildContext context,
    required SettingsProvider settingsProvider,
  }) async {
    var settingsModel = SettingsModel(
      temperatureMeasurementUnit:
          settingsProvider.temperatureMetricsSelectedValue,
      language: settingsProvider.appLanguageSelectedValue,
      defaultCity: settingsProvider.defaultCityValue,
    );

    final hiveBox = HiveSecureStorage.getHiveBox();
    HiveSecureStorage.updateInfo(
      hiveBox,
      GlobalConstants.kAppDetailsStorageKey,
      // Save settingsModel as ToString JsonEncode()
      settingsModel.toString(),
    );

    // Change Language
    _changeLanguage(
      context: context,
      settingsProvider: settingsProvider,
    );

    // Set Data Accordingly To Settings Modal
    GlobalConstants.appLanguageForWeatherAPICall = settingsModel.language;
    GlobalConstants.temperatureMetricsForWeatherAPICall =
        settingsModel.temperatureMeasurementUnit;
    GlobalConstants.cityNameForWeatherAPICall =
        GlobalConstants.kDefaultCityName = settingsModel.defaultCity;

    // Make API Call To Get Weather For for Changed App lang
    await _getCurrentWeatherData(context);

    // Reset Values After Saving/Disabled Edit
    settingsProvider.requestResetSettingsValues();
  }
}
