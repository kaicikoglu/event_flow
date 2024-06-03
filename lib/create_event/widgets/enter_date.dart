import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterDate extends StatefulWidget {
  final String argument;
  final double width;
  final TextEditingController controller;

  const EnterDate({
    super.key,
    required this.argument,
    required this.width,
    required this.controller,
  });

  @override
  _EnterDateState createState() => _EnterDateState();
}

class _EnterDateState extends State<EnterDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.controller.text = DateFormat('dd.MM.yyyy').format(selectedDate);
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
            onPressed: () => _selectDate(context),
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
                    Icons.calendar_today,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
