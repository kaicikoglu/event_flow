import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/floating_action_button.dart';

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

Widget getTitle(String location) {
  switch (location) {
    case '/':
      return const Text('Mein EventFlow');
    case '/announcements':
      return const Text('Ankündigungen');
    case '/settings':
      return const Text('Einstellungen');
    case '/profile':
      return const Text('Profil');
    default:
      return const Text('Mein EventFlow');
  }
}

Widget? getFloatingActionButton(String location, BuildContext context) {
  if (location == '/') {
    return CustomFAB(onPressed: () {
      context.push('/createEvent');
    });
  }
  return null;
}

bool shouldShowBackButton(String location) {
  return location != '/' &&
      location != '/announcements' &&
      location != '/settings' &&
      location != '/profile';
}
