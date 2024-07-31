import 'package:flutter/material.dart';

import '../services/create_announcement_controller.dart';

class AnnouncementDescription extends StatelessWidget {
  final CreateAnnouncementController controller;

  const AnnouncementDescription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.descriptionController,
      decoration: const InputDecoration(labelText: 'Beschreibung'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Füge eine Beschreibung hinzu';
        }
        return null;
      },
    );
  }
}
