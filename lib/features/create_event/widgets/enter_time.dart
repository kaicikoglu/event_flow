// path: lib/widgets/enter_time.dart

import 'package:flutter/material.dart';
import '../services/create_event_controller.dart';

class EnterTime extends StatelessWidget {
  final String argument;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final CreateEventController eventController;

  const EnterTime({
    super.key,
    required this.argument,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
    required this.eventController,
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
        const Spacer(),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select Time',
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
              suffixIcon: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () {
                  eventController.selectTime(context);
                },
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
