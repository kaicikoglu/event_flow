import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/announcement/announcement_data_model.dart';
import '../../../data_models/event/event_data_model.dart';

class AnnouncementWidget extends StatelessWidget {
  final Announcement announcement;
  final Event event;

  const AnnouncementWidget(
      {super.key, required this.announcement, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(announcement.title),
        subtitle: Text(
          '${announcement.sentDate.toLocal().toString().split(' ')[0]} - ${announcement.description}',
        ),
        onTap: () {
          context.push('/event', extra: event);
        },
      ),
    );
  }
}
