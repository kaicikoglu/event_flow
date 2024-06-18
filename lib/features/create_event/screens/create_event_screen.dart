// lib/features/create_event/screens/create_event_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../services/event_list_notifier.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/enter_date.dart';
import '../widgets/enter_location.dart';
import '../widgets/enter_text.dart';
import '../widgets/enter_time.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final eventNameController = TextEditingController();
  final timeController = TextEditingController();
  final startDateController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      backButton: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String eventName = eventNameController.text;
                    String startDate = startDateController.text;
                    String time = timeController.text;
                    String location = locationController.text;

                    final event = Event()
                      ..title = eventName
                      ..date = DateTime.parse(startDate)
                      ..time = time
                      ..location = location
                      ..participants =
                          '0/0'; // Initialize participants as needed

                    final eventNotifier =
                        ref.read(eventNotifierProvider.notifier);
                    await eventNotifier.addEvent(event);

                    if (mounted) {
                      context.go(
                        '/event',
                        extra: {
                          'title': eventName,
                          'date': startDate,
                          'time': time,
                          'location': location,
                          'attendees': 'attendees',
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    eventNameController.dispose();
    timeController.dispose();
    startDateController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
