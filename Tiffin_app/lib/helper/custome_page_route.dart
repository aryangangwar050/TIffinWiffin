import 'package:flutter/material.dart';

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({WidgetBuilder builder})
      : super(
          builder: builder,
        );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    Animation<double> onlyForwardAnimation;
    switch (animation.status) {
      case AnimationStatus.reverse:
      case AnimationStatus.dismissed:
        onlyForwardAnimation = kAlwaysCompleteAnimation;
        break;
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        onlyForwardAnimation = animation;
        break;
    }
    return new FadeTransition(opacity: animation, child: child);
    // return theme.buildTransitions<T>(
    //     this, context, onlyForwardAnimation, secondaryAnimation, child);
  }
}
