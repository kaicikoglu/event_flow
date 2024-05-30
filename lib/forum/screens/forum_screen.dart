import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      selectedIndex: 0,
      child: Center(
        child: Text('Forum Screen'),
      ),
    );
  }
}
