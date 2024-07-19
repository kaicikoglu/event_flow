import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../services/event_list_provider.dart';
import '../widgets/dismissible_event_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventListState = ref.watch(eventNotifierProvider);

    return Scaffold(
      body: eventListState.when(
        data: (events) {
          if (events.isEmpty) {
            return const Center(
              child: Text(
                'No events available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return DismissibleEventCard(
                event: event,
                onDismissed: () {
                  ref
                      .read(eventNotifierProvider.notifier)
                      .removeEvent(event.id);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          context.push('/createEvent');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
