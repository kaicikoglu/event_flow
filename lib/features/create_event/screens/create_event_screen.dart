import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event_data_model.dart';
import '../../../services/event_list_notifier.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/enter_date.dart';
import '../widgets/enter_location.dart';
import '../widgets/enter_text.dart';
import '../widgets/enter_time.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  final Event? event;

  const CreateEventScreen({Key? key, this.event}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final eventNameController = TextEditingController();
  final timeController = TextEditingController();
  final startDateController = TextEditingController();
  final locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Event? editingEvent;

  @override
  void initState() {
    super.initState();
    editingEvent = widget.event;
    print(editingEvent?.time.toString());
    if (editingEvent != null) {
      eventNameController.text = editingEvent!.title;
      timeController.text = editingEvent!.time;
      startDateController.text =
          editingEvent!.date.toIso8601String().split('T').first;
      locationController.text = editingEvent!.location;
    }
  }

  TimeOfDay? _parseTimeOfDay(String time) {
    final format = DateFormat
        .jm(); // or you can use DateFormat("hh:mm a") for a 12-hour format
    try {
      final dateTime = format.parse(time);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      selectedIndex: 0,
      backButton: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(editingEvent != null ? 'Edit Event' : 'Create Event'),
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
                      updateText: editingEvent?.title,
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
                      updateTime: editingEvent != null
                          ? _parseTimeOfDay(editingEvent!.time)
                          : null,
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
                      updateDate: editingEvent?.date,
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
                      updateLocation: editingEvent?.location,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              CustomWideButton(
                text: editingEvent != null ? 'Update Event' : 'Create Event',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String eventName = eventNameController.text;
                    String startDate = startDateController.text;
                    String time = timeController.text;
                    String location = locationController.text;

                    final event = Event()
                      ..id = editingEvent?.id ?? Isar.autoIncrement
                      ..title = eventName
                      ..date = DateTime.parse(startDate)
                      ..time = time
                      ..location = location
                      ..participants = editingEvent?.participants ??
                          '0/0'; // Keep participants if editing

                    final eventNotifier =
                        ref.read(eventNotifierProvider.notifier);

                    if (editingEvent != null) {
                      await eventNotifier.updateEvent(
                          event); // Implement updateEvent in your notifier
                    } else {
                      await eventNotifier.addEvent(event);
                    }

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
