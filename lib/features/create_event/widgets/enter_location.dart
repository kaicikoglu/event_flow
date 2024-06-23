import 'package:flutter/material.dart';

class EnterLocation extends StatefulWidget {
  final String argument;
  final String hintText;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? updateLocation;

  const EnterLocation({
    super.key,
    required this.argument,
    required this.hintText,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
    this.updateLocation,
  });

  @override
  _EnterLocationState createState() => _EnterLocationState();
}

class _EnterLocationState extends State<EnterLocation> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.updateLocation ?? '';
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
          child: Form(
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator,
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
            ),
          ),
        ),
      ],
    );
  }
}
