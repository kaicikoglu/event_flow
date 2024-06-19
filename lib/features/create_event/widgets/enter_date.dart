import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterDate extends StatefulWidget {
  final String argument;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final DateTime? updateDate;

  const EnterDate({
    super.key,
    required this.argument,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
    this.updateDate,
  });

  @override
  _EnterDateState createState() => _EnterDateState();
}

class _EnterDateState extends State<EnterDate> {
  @override
  void initState() {
    super.initState();
    if (widget.updateDate != null) {
      widget.controller.text =
          DateFormat('yyyy-MM-dd').format(widget.updateDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.updateDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
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
        const Spacer(),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Select Date',
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
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
