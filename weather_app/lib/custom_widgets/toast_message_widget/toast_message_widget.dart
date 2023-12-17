import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/custom_widgets/loading_indicator_widget/loading_indicator_overlay.dart';

class ToastMessages {
  String btnOkayText = 'Okay'.tr();

  //region Bottom Toast Message, Used Without Any Context

  void showSuccessBottomToastMessage({
    required String message,
  }) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showInfoBottomToastMessage({
    required String message,
  }) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showErrorBottomToastMessage({
    required String message,
  }) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  //endregion

  void showSuccessToastMessage({
    required String message,
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: '${'Success'.tr()}!',
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: const Color.fromRGBO(
          0,
          202,
          113,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showErrorToastMessage({
    required String message,
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: '${'Error'.tr()}!',
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: const Color.fromRGBO(
          217,
          62,
          71,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showInfoToastMessage({
    required String message,
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        dialogType: DialogType.info,
        animType: AnimType.topSlide,
        title: '${'Info'.tr()}!',
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: const Color.fromRGBO(
          0,
          152,
          255,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showWarningToastMessage({
    required String message,
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: '${'Warning'.tr()}!',
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: const Color.fromRGBO(
          254,
          184,
          0,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showSuccessWithCallbackFunctionToastMessage({
    required String message,
    required void Function()
    btnOkOnPress, // Add parameter for btnOkOnPress callback
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        isDense: true,
        onDismissCallback: (type) {
          if (type != DismissType.btnOk) {
            btnOkOnPress();
          }
        },
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: '${'Success'.tr()}!',
        desc: message,
        btnOkOnPress: btnOkOnPress,
        btnOkColor: const Color.fromRGBO(
          0,
          202,
          113,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showErrorWithCallbackFunctionToastMessage({
    required String message,
    required void Function()
    btnOkOnPress, // Add parameter for btnOkOnPress callback
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        isDense: true,
        onDismissCallback: (type) {
          if (type != DismissType.btnOk) {
            btnOkOnPress();
          }
        },
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: '${'Error'.tr()}!',
        desc: message,
        btnOkOnPress: btnOkOnPress,
        btnOkColor: const Color.fromRGBO(
          217,
          62,
          71,
          1,
        ),
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }

  void showConfirmationBeforeActionToastMessage({
    required String message,
    required void Function()
    btnOkOnPress, // Add parameter for btnOkOnPress callback
  }) {
    try {
      final buildContext = overlayKey.currentState!.context;

      AwesomeDialog(
        autoHide: const Duration(
          seconds: 10,
        ),
        context: buildContext,
        isDense: true,
        dialogType: DialogType.infoReverse,
        animType: AnimType.topSlide,
        title: '${'Confirmation'.tr()}!',
        desc: message,
        btnCancelOnPress: () {},
        btnCancelIcon: Icons.cancel,
        btnOkOnPress: btnOkOnPress,
        btnOkText: btnOkayText,
        btnOkIcon: Icons.check_circle,
        width: 500,
      ).show();
    } catch (ex) {
      //something went wrong/no context found
      debugPrint("Error: $ex");
    }
  }
}
