// path: lib/widgets/create_announcement_button.dart

import 'package:flutter/material.dart';

import '../../../data_models/event_data_model.dart';
import '../services/create_announcement_controller.dart';

class CreateAnnouncementButton extends StatelessWidget {
  final CreateAnnouncementController controller;
  final Event event;
  final GlobalKey<FormState> formKey;

  const CreateAnnouncementButton({
    super.key,
    required this.controller,
    required this.event,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.createAnnouncement(context, event, formKey);
      },
      child: const Text('Create Announcement'),
    );
  }
}
