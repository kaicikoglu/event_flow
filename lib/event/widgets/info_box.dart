import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final IconData icon1;
  final String text1;
  final IconData icon2;
  final String text2;

  const InfoBox({
    super.key,
    required this.icon1,
    required this.text1,
    required this.icon2,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon1),
        const SizedBox(width: 8),
        Text(text1),
        const SizedBox(width: 64),
        Icon(icon2),
        const SizedBox(width: 8),
        Text(text2),
      ],
    ));
  }
}
