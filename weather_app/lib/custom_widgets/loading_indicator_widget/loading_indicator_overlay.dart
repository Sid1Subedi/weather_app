import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

class ShowOverlayLoadingIndicator extends NavigatorObserver {
  static Future<void> performTaskWithLoadingOverlay(
      Future Function()? task, {
        Duration? timeoutDuration,
        String? textMessage,
      }) async {
    final buildContext = overlayKey.currentState!.context;
    OverlayEntry? overlayEntry;

    Duration timeout = timeoutDuration ??
        const Duration(
          seconds: 18,
        );

    void showOverlay() {
      overlayEntry = OverlayEntry(
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.black.withOpacity(
              0.5,
            ),
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      //offset: Offset(0, 4),
                      color: Colors.blueAccent, //edited
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitThreeBounce(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            color: index.isEven ? Colors.red : Colors.blue,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      textMessage ?? "Waiting...",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      Overlay.of(buildContext).insert(overlayEntry!);
    }

    void hideOverlay() {
      if (overlayEntry != null) {
        overlayEntry!.remove();
        overlayEntry = null;
      }
    }

    showOverlay();

    if (task != null) {
      try {
        await Future.any([
          task(),
          Future.delayed(timeout),
        ]);
      } on TimeoutException catch (e) {
        debugPrint('Error performing task: $e');
      }
    }

    hideOverlay();
  }
}
