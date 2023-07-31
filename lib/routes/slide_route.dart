import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final String direction;
  final bool? fullScreenDialog;

  SlideRoute(
      {required this.page, required this.direction, this.fullScreenDialog})
      : super(
            fullscreenDialog: fullScreenDialog ?? false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final double offsetX =
                  (direction != 'right' && direction != 'left')
                      ? 0
                      : direction == 'right'
                          ? -1
                          : 1;
              final double offsetY =
                  (direction != 'top' && direction != 'bottom')
                      ? 0
                      : direction == 'bottom'
                          ? -1
                          : 1;

              return SlideTransition(
                  position:
                      Tween(begin: Offset(offsetX, offsetY), end: Offset.zero)
                          .chain(CurveTween(curve: Curves.ease))
                          .animate(animation),
                  child: child);
            });
}
