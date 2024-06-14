import 'package:flutter/material.dart';

class EnterText extends StatelessWidget {
  final String argument;
  final String hintText;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EnterText({
    super.key,
    required this.argument,
    required this.hintText,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
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
          width: width,
          height: height,
          child: Form(
            child: TextFormField(
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(73, 81, 86, 100),
                ),
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
        ),
      ],
    );
  }
}
