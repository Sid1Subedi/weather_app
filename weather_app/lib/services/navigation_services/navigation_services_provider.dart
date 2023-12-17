import 'package:flutter/material.dart';
import 'package:weather_app/src/settings_page/views/settings_page_view.dart';
import 'package:weather_app/src/weather_home_page/views/weather_home_page_view.dart';

class NavigationServiceProvider extends ChangeNotifier {

  //region Bottom Navigation Bar

  int _selectedBottomNavBarIndex = 0;

  int get selectedBottomNavBarIndex => _selectedBottomNavBarIndex;

  set _setSelectedBottomNavBarIndex(int selectedBottomNavBarIndex) {
    _selectedBottomNavBarIndex = selectedBottomNavBarIndex;
    notifyListeners();
  }

  List<Widget> getListOfIndexedPages() {
    List<Widget> pages = [
      const WeatherHomePageView(),
      const SettingsPageView(),
    ];

    return pages;
  }

  requestChangeSelectedPageIndex({
    required int index,
  }) {
    _setSelectedBottomNavBarIndex = index;

    notifyListeners();
  }

  //endregion
}
