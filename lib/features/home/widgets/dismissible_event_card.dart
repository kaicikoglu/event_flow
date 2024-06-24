// path: lib/features/home/widgets/dismissible_event_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../services/event_list_notifier.dart';
import 'event_card.dart';

class DismissibleEventCard extends ConsumerStatefulWidget {
  final Event event;

  const DismissibleEventCard({super.key, required this.event});

  @override
  _DismissibleEventCardState createState() => _DismissibleEventCardState();
}

class _DismissibleEventCardState extends ConsumerState<DismissibleEventCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.event.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          context.go('/createEvent', extra: widget.event);
        } else if (direction == DismissDirection.endToStart) {
          final eventNotifier = ref.read(eventNotifierProvider.notifier);
          eventNotifier.removeEvent(widget.event.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.event.title} dismissed')),
          );
        }
      },
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: EventCard(event: widget.event),
    );
  }
}
