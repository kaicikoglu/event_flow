// lib/controllers/create_event_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../../../data_models/event_data_model.dart';
import '../../../services/event_list_notifier.dart';

class CreateEventController {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Event? editingEvent;

  CreateEventController({this.editingEvent}) {
    if (editingEvent != null) {
      eventNameController.text = editingEvent!.title;
      timeController.text = editingEvent!.time;
      startDateController.text = editingEvent!.date.toIso8601String().split('T').first;
      locationController.text = editingEvent!.location;
    }
  }

  TimeOfDay? parseTimeOfDay(String time) {
    final format = DateFormat.jm();
    try {
      final dateTime = format.parse(time);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    } catch (e) {
      return null;
    }
  }

  Future<void> handleSubmit(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      String eventName = eventNameController.text;
      String startDate = startDateController.text;
      String time = timeController.text;
      String location = locationController.text;
      String participants = editingEvent?.participants ?? '0/0';

      final event = Event()
        ..id = editingEvent?.id ?? Isar.autoIncrement
        ..title = eventName
        ..date = DateTime.parse(startDate)
        ..time = time
        ..location = location
        ..participants = participants;

      final eventNotifier = ref.read(eventNotifierProvider.notifier);

      if (editingEvent != null) {
        await eventNotifier.updateEvent(event);
      } else {
        await eventNotifier.addEvent(event);
      }

      if (context.mounted) {
        context.go('/event', extra: event);
      }
    }
  }

  void dispose() {
    eventNameController.dispose();
    timeController.dispose();
    startDateController.dispose();
    locationController.dispose();
  }
}
