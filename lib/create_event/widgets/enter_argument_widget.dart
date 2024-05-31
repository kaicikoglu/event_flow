import 'package:flutter/material.dart';

class EnterArgumentWidget extends StatelessWidget {
  final String argument;
  final String hintText;

  const EnterArgumentWidget({
    super.key,
    required this.argument,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          argument,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(), // Pushes the input field to the right
        SizedBox(
          width: 275,
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide: BorderSide(
                  color: Color.fromRGBO(73, 81, 86, 100),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
