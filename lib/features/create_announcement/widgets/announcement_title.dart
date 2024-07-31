import 'package:flutter/material.dart';

import '../../../data_models/event/event_data_model.dart';

class AnnouncementTitle extends StatelessWidget {
  final Event event;

  const AnnouncementTitle({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Text('Event Title: ${event.title}');
  }
}
