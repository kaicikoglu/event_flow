import 'package:flutter/material.dart';

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
    case '/forum':
      return const Text('Forum');
    case '/vote':
      return const Text('Vote');
    case '/todo':
      return const Text('ToDo');
    case '/resources':
      return const Text('Resources');
    default:
      return const Text('Mein EventFlow');
  }
}

bool shouldShowBackButton(String location) {
  return location != '/' &&
      location != '/announcements' &&
      location != '/settings' &&
      location != '/profile';
}
