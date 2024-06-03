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

  // Add other controllers as needed

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      title: const Text('Create Event'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  EnterText(
                    argument: 'Event Name:',
                    hintText: 'Enter event name',
                    width: 250,
                    controller: eventNameController, // Pass the controller
                  ),
                  const SizedBox(height: 16),
                  EnterTime(
                    argument: 'Time:',
                    width: 250,
                    controller: timeController, // Pass the controller
                  ),
                  const SizedBox(height: 16),
                  EnterDate(
                    argument: 'Date:',
                    width: 250,
                    controller: startDateController, // Pass the controller
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
                // Get other field values as needed

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventScreen(
                            title: eventName,
                            date: startDate,
                            time: time,
                            location: 'location',
                            attendees: 'attendees')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
