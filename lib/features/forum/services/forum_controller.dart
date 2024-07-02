// path: lib/controllers/announcement_controller.dart

import 'package:event_flow/features/announcement/services/announcement_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../data_models/event/event_data_model.dart';

class ForumController {
  void dispose() {
    // No need for controller disposal here as we don't use any controllers
  }

  Future<void> createAnnouncement(BuildContext context, WidgetRef ref,
      Event event) async {
    const String announcementText = "Neuer Forum Eintrag erstellt!";
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
