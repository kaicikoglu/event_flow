
import 'package:event_flow/features/announcement/services/announcement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event/event_data_model.dart';

class TodoController {
  void dispose() {
  }

  Future<void> createAnnouncement(BuildContext context, WidgetRef ref,
      Event event) async {
    const String announcementText = "Neue Aufgabe erstellt!";
    final isar = Isar.getInstance();

    if (isar != null) {
      await event.createAnnouncement(isar, announcementText);
      ref.read(announcementProvider.notifier)
          .markEventWithNewAnnouncement(event.id);

      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isar instance is not available')),
      );
    }
  }
}
