import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/services/navigation_services/navigation_services_provider.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    var navigationProvider = Provider.of<NavigationServiceProvider>(
      context,
      listen: false,
    );

    _pageController = PageController(
      initialPage: navigationProvider.selectedBottomNavBarIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationServiceProvider = Provider.of<NavigationServiceProvider>(
      context,
    );

    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          body: PageView(
            controller: _pageController,
            children: navigationServiceProvider.getListOfIndexedPages(),
            onPageChanged: (index) {
              navigationServiceProvider.requestChangeSelectedPageIndex(
                index: index,
              );
            },
          ),
          bottomNavigationBar: _bottomNavBar(
            navigationServiceProvider: navigationServiceProvider,
          ),
        ),
      ),
    );
  }

  Widget _bottomNavBar({
    required NavigationServiceProvider navigationServiceProvider,
  }) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        top: width * .07,
        bottom: width * .07,
        left: width * .2,
        right: width * .2,
      ),
      height: width * .155,
      decoration: BoxDecoration(
        color: AppColorConstants.pageBgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(
            navigationServiceProvider: navigationServiceProvider,
            index: 0,
            icon: Icons.home_rounded,
            label: 'Home',
            width: width,
          ),
          buildNavItem(
            navigationServiceProvider: navigationServiceProvider,
            index: 1,
            icon: Icons.settings,
            label: 'Settings',
            width: width,
          ),
        ],
      ),
    );
  }

  Widget buildNavItem({
    required NavigationServiceProvider navigationServiceProvider,
    required int index,
    required IconData icon,
    required String label,
    required double width,
  }) {
    return InkWell(
      onTap: () {
        if (_pageController.page != index) {
          _pageController.animateToPage(
            index,
            curve: Curves.ease,
            duration: const Duration(
              milliseconds: 300,
            ),
          );
        }
        HapticFeedback.lightImpact();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == navigationServiceProvider.selectedBottomNavBarIndex
                ? width * .32
                : width * .18,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height:
                  index == navigationServiceProvider.selectedBottomNavBarIndex
                      ? width * .12
                      : 0,
              width:
                  index == navigationServiceProvider.selectedBottomNavBarIndex
                      ? width * .32
                      : 0,
              decoration: BoxDecoration(
                color:
                    index == navigationServiceProvider.selectedBottomNavBarIndex
                        ? AppColorConstants.purpleColor.withOpacity(.2)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            width: index == navigationServiceProvider.selectedBottomNavBarIndex
                ? width * .31
                : width * .18,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index ==
                              navigationServiceProvider
                                  .selectedBottomNavBarIndex
                          ? width * .13
                          : 0,
                    ),
                    AnimatedOpacity(
                      opacity: index ==
                              navigationServiceProvider
                                  .selectedBottomNavBarIndex
                          ? 1
                          : 0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Text(
                        index ==
                                navigationServiceProvider
                                    .selectedBottomNavBarIndex
                            ? label
                            : '',
                        style: const TextStyle(
                          color: AppColorConstants.purpleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index ==
                              navigationServiceProvider
                                  .selectedBottomNavBarIndex
                          ? width * .03
                          : 20,
                    ),
                    Icon(
                      icon,
                      size: width * .076,
                      color: index ==
                              navigationServiceProvider
                                  .selectedBottomNavBarIndex
                          ? AppColorConstants.purpleColor
                          : Colors.black26,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
