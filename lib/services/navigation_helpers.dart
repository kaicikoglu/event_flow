import 'package:flutter/cupertino.dart';

int getSelectedIndex(String location) {
  switch (location) {
    case '/':
      return 0;
    case '/announcements':
      return 1;
    case '/settings':
      return 2;
    case '/profile':
      return 3;
    default:
      return 0;
  }
}

Widget slideFromBottomTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset(0.0, 0.0);
  const curve = Curves.easeInOut;

  final tween = Tween(begin: begin, end: end);
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}
