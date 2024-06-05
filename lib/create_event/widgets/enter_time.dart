import 'package:flutter/material.dart';

class EnterTime extends StatefulWidget {
  final String argument;
  final double width;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EnterTime({
    super.key,
    required this.argument,
    required this.width,
    required this.height,
    required this.controller,
    this.validator,
  });

  @override
  _EnterTimeState createState() => _EnterTimeState();
}

class _EnterTimeState extends State<EnterTime> {
  TimeOfDay selectedTime = TimeOfDay.now();
  Color color = const Color.fromRGBO(73, 81, 86, 100);

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
        const Spacer(),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: FormField<String>(
            validator: widget.validator,
            builder: (FormFieldState<String> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _selectTime(context);
                      color = Colors.black;
                      state.didChange(widget.controller.text);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color.fromRGBO(73, 81, 86, 100),
                        width: 1.0,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          widget.controller.text.isEmpty
                              ? 'Select Time'
                              : widget.controller.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: color,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.access_time_outlined,
                          size: 20.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        state.errorText ?? '',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
