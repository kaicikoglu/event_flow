import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../announcement/services/announcement_provider.dart';

class VoteOverviewController {
  void dispose() {}

  Future<void> createAnnouncement(
      BuildContext context, WidgetRef ref, Event event) async {
    const String announcementText = "Neues Voting erstellt!";
    final isar = Isar.getInstance();

    if (isar != null) {
      await event.createAnnouncement(isar, announcementText);
      ref
          .read(announcementProvider.notifier)
          .markEventWithNewAnnouncement(event.id);
      if(!context.mounted) return;
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isar instance is not available')),
      );
    }
  }
}
