import 'package:flutter/material.dart';
import 'package:weather_app/services/navigation_services/page_routing_animation.dart';

class NavigationRoutingServices {
  void navigateToRoute({
    required BuildContext context,
    required Widget child,
  }) {
    Navigator.of(context).push(
      PageRoutingAnimation(
        child: child,
      ),
    );
  }
}
