import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/app_color_constants.dart';
import 'package:weather_app/constants/global_constants.dart';

class ScaffoldWidget extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final bool showBackBtn;

  const ScaffoldWidget({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.showBackBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext scaffoldContext) {
        return Scaffold(
          backgroundColor: AppColorConstants.pageBgColor,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar bg color
              statusBarColor: Colors.transparent,

              // Status Bar Icons Color
              statusBarIconBrightness: Brightness.light, // For Android (light icons)
              statusBarBrightness: Brightness.light, // For iOS (light icons)
            ),
            flexibleSpace: Container(
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
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                showBackBtn
                    ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: GlobalConstants.kConstWidth,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pop(false); // Close the popup
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColorConstants.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GlobalConstants.kConstWidth,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Text(
                  appBarTitle,
                  style: TextStyle(
                    fontSize: GlobalConstants.kHeadingTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColorConstants.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          body: body,
        );
      },
    );
  }
}
