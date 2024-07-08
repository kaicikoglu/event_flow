import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navbar.dart'; // Ensure the path is correct

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final Widget? title;
  final bool centerTitle;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final BackButton? backButton;

  const BaseScreen({
    super.key,
    required this.child,
    required this.selectedIndex,
    this.title,
    this.centerTitle = false,
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
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.9; // Set to 90% of screen width
    double maxContentWidth = 600; // Maximum width

    if (contentWidth > maxContentWidth) {
      contentWidth = maxContentWidth;
    }

    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: title,
        centerTitle: centerTitle, // Center the title
      ),
      body: Center(
        child: Container(
          width: contentWidth,
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
