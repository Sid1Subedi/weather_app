import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color_constants.dart';

class CustomOkayElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnText;

  const CustomOkayElevatedButton({
    Key? key,
    required this.onPressed,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(AppColorConstants.purpleColor),
        elevation: MaterialStateProperty.resolveWith<double>((states) {
          if (states.contains(MaterialState.pressed)) {
            return 8; // Little Elevation Effect When Pressed
          }
          return 2; // Default Elevation for this Button
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Container(
        width: 160,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColorConstants.whiteColor,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
