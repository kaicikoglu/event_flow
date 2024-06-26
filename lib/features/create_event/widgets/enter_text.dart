import 'package:flutter/material.dart';

class EnterText extends StatefulWidget {
  final String argument;
  final String hintText;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? updateText;

  const EnterText({
    super.key,
    required this.argument,
    required this.hintText,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
    this.updateText,
  });

  @override
  _EnterTextState createState() => _EnterTextState();
}

class _EnterTextState extends State<EnterText> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.updateText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.argument,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Spacer(), // Pushes the input field to the right
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
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
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
