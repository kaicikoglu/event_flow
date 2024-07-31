import 'package:flutter/material.dart';

import '../services/create_announcement_controller.dart';

class AnnouncementDescription extends StatelessWidget {
  final CreateAnnouncementController controller;

  const AnnouncementDescription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.descriptionController,
      decoration: const InputDecoration(labelText: 'Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }
}
