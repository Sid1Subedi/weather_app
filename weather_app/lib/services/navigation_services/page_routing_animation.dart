import 'package:flutter/material.dart';

class PageRoutingAnimation extends PageRouteBuilder {
  final Widget child;
  final int transitionDurationMilliSec;
  final int reverseTransitionDurationMilliSec;
  final AxisDirection direction;

  PageRoutingAnimation({
    required this.child,
    this.transitionDurationMilliSec = 300,
    this.reverseTransitionDurationMilliSec = 300,
    this.direction = AxisDirection.up,
  }) : super(
          transitionDuration: Duration(
            milliseconds: transitionDurationMilliSec,
          ),
          reverseTransitionDuration: Duration(
            milliseconds: reverseTransitionDurationMilliSec,
          ),
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getInitialOffset(),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset getInitialOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
