import 'package:flutter/material.dart';

class ButtonGridView extends StatelessWidget {
  final List<Widget> children;

  const ButtonGridView({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: children,
      ),
    );
  }
}
