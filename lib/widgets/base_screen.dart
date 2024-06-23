// lib/widgets/base_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navbar.dart'; // Ensure the path is correct

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final double contentWidth;
  final Widget title;
  final Widget? floatingActionButton; // Add this line
  final FloatingActionButtonLocation?
      floatingActionButtonLocation; // Add this line
  final BackButton? backButton; // Add this line

  const BaseScreen({
    super.key,
    required this.child,
    required this.selectedIndex,
    this.contentWidth = 600,
    required this.title,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backButton,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/announcements');
        break;
      case 2:
        context.go('/settings');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: title,
      ),
      body: Center(
        child: Container(
          width: contentWidth,
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
      floatingActionButton: floatingActionButton,
      // Add this line
      floatingActionButtonLocation: floatingActionButtonLocation,
      // Add this line
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
