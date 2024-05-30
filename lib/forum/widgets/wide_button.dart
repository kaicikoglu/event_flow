// lib/widgets/custom_wide_button.dart
import 'package:flutter/material.dart';

class CustomWideButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomWideButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(
                  color: Color.fromRGBO(73, 81, 86, 100), width: 1.0)),
        ),
        child: Text(text),
      ),
    );
  }
}
