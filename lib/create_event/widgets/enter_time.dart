import 'package:flutter/material.dart';

class EnterTime extends StatefulWidget {
  final String argument;
  final double width;
  final TextEditingController controller;

  const EnterTime({
    super.key,
    required this.argument,
    required this.width, required this.controller,
  });

  @override
  _EnterTimeState createState() => _EnterTimeState();
}

class _EnterTimeState extends State<EnterTime> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.controller.text = selectedTime.format(context);
      });
    }
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
          child: OutlinedButton(
            onPressed: () => _selectTime(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color.fromRGBO(73, 81, 86, 100),
                width: 1.0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  // Added space between icon and text
                  Text(
                    widget.controller.text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.access_time_outlined,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  // Added clock icon here
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
