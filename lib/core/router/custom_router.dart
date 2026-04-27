import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomRouteTransition {
  static Widget sharedAxis(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Here you can use any Existing Transition class in Flutter
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }

  static Widget ripple(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Here you can use any Existing Transition class in Flutter
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      child: child,
      builder:
          (context, double value, child) => ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback:
                (rect) => RadialGradient(
                  radius: value * 5,
                  colors: const [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.55, 0.6, 1.0],
                  center: const FractionalOffset(0.55, 0.5),
                ).createShader(rect),
            child: child,
          ),
    );
  }
}
