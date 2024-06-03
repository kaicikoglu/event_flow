// main.dart
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import 'home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EventFlow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(73, 81, 86, 100)),
          useMaterial3: true,
        ),
        home: const HomeContent(),
        routes: {
          '/home': (context) => const HomeContent(),
          '/chat': (context) => const BaseScreen(
                selectedIndex: 1,
                title: Text('Chat'),
                child: Center(child: Text('Chat Screen')),
              ),
          '/settings': (context) => const BaseScreen(
              selectedIndex: 2,
              title: Text('Settings'),
              child: Center(child: Text('Chat Screen'))),
          '/profile': (context) =>
              const Scaffold(body: Center(child: Text('Profile Screen'))),
        });
  }
}
