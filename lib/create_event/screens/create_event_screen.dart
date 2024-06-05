import 'package:event_flow/create_event/widgets/enter_location.dart';
import 'package:event_flow/create_event/widgets/enter_time.dart';
import 'package:event_flow/event/screens/event_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_screen.dart';
import '../../widgets/wide_button.dart';
import '../widgets/enter_date.dart';
import '../widgets/enter_text.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final eventNameController = TextEditingController();
  final timeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      title: const Text('Create Event'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    EnterText(
                      argument: 'Event Name:',
                      hintText: 'Enter event name',
                      width: 250,
                      height: 60,
                      controller: eventNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    EnterTime(
                      argument: 'Time:',
                      width: 250,
                      height: 60,
                      controller: timeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter time';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    EnterDate(
                      argument: 'Date:',
                      width: 250,
                      height: 60,
                      controller: startDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    EnterLocation(
                      argument: 'Location:',
                      hintText: 'Enter location',
                      width: 250,
                      height: 60,
                      controller: locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              CustomWideButton(
                text: 'Create Event',
                onPressed: () {
                  String eventName = eventNameController.text;
                  String startDate = startDateController.text;
                  String time = timeController.text;
                  String location = locationController.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventScreen(
                        title: eventName,
                        date: startDate,
                        time: time,
                        location: location,
                        attendees: 'attendees',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
