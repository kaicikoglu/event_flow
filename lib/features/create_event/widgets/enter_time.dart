import 'package:flutter/material.dart';

class EnterTime extends StatefulWidget {
  final String argument;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TimeOfDay? updateTime;

  const EnterTime({
    super.key,
    required this.argument,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
    this.updateTime,
  });

  @override
  _EnterTimeState createState() => _EnterTimeState();
}

class _EnterTimeState extends State<EnterTime> {
  @override
  void initState() {
    super.initState();
    if (widget.updateTime != null) {
      widget.controller.text = widget.updateTime!.format(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.updateTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != widget.updateTime) {
      setState(() {
        widget.controller.text = picked.format(context);
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
                  _selectTime(context);
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
