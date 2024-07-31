import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../services/event_list_provider.dart';

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
      startDateController.text =
          editingEvent!.date.toIso8601String().split('T').first;
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: editingEvent?.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: parseTimeOfDay(timeController.text) ?? TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  Future<void> handleSubmit(
      BuildContext context, WidgetRef ref, Event? updateEvent) async {
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

      if (updateEvent != null) {
        context.pop();
      }

      if (context.mounted) {
        context.replace('/event', extra: event);
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
