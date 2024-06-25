// path: lib/widgets/create_announcement_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event_data_model.dart';
import '../services/create_announcement_controller.dart';

class CreateAnnouncementButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        controller.createAnnouncement(context, ref, event, formKey);
      },
      child: const Text('Create Announcement'),
    );
  }
}
