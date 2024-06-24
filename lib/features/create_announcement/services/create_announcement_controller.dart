// path: lib/controllers/announcement_controller.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event_data_model.dart';

class CreateAnnouncementController {
  final TextEditingController descriptionController = TextEditingController();

  void dispose() {
    descriptionController.dispose();
  }

  Future<void> createAnnouncement(
      BuildContext context, Event event, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final String description = descriptionController.text;
      final isar = Isar.getInstance();

      if (isar != null) {
        await event.createAnnouncement(isar, description);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Announcement created successfully!')),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Isar instance is not available')),
        );
      }
    }
  }
}
