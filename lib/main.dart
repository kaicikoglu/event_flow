// main.dart
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeContent(),
      routes: {
        '/home': (context) => const HomeContent(),
        '/chat': (context) => const Scaffold(body: Center(child: Text('Chat Screen'))),
        '/settings': (context) => const Scaffold(body: Center(child: Text('Settings Screen'))),
        '/profile': (context) => const Scaffold(body: Center(child: Text('Profile Screen'))),
      }
    );
  }
}
