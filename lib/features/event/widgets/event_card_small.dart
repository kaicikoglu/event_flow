import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../services/event_list_provider.dart';

class EventCardSmall extends ConsumerWidget {
  final Event event;

  const EventCardSmall({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(eventNotifierProvider.notifier).checkAnnouncement(event);
    return GestureDetector(
      onTap: () {
        context.push('/createEvent', extra: event);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            color: Color.fromRGBO(73, 81, 86, 100),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(event.date.toIso8601String().split('T').first),
                  ),
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(event.time)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(event.location)),
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(event.participants)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
