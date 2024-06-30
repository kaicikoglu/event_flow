import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'navbar.dart'; // Ensure the path is correct

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final double contentWidth;
  final Widget? title;
  final bool centerTitle;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final BackButton? backButton;

  const BaseScreen({
    super.key,
    required this.child,
    required this.selectedIndex,
    this.contentWidth = 600,
    this.title,
    this.centerTitle = false, // Default to false if not provided
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
