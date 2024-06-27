import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event_data_model.dart';
import '../services/home_content_controller.dart';
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
        ref
            .read(homeContentControllerProvider.notifier)
            .handleDismiss(context, ref, widget.event, direction);
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
