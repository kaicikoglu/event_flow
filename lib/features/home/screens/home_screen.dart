// lib/features/home/screens/home_content.dart

import 'package:event_flow/widgets/base_screen.dart';
import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/event_list_notifier.dart';
import '../widgets/event_card.dart';
import '../widgets/search_bar.dart';

class HomeContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(eventNotifierProvider);

    return BaseScreen(
      title: const Center(child: Text('Mein EventFlow')),
      selectedIndex: 0,
      floatingActionButton: CustomFAB(onPressed: () {
        context.push('/createEvent');
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Column(
        children: [
          CustomSearchBar(
            hintText: 'Suche nach Events',
            controller: TextEditingController(), // Use a controller for search functionality
            onChanged: (value) {
              // Handle the search bar input here
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final eventNotifier = ref.read(eventNotifierProvider.notifier);
                await eventNotifier.loadEvents();
              },
              child: eventsState.when(
                data: (events) {
                  if (events.isEmpty) {
                    return const Center(child: Text('No events found'));
                  } else {
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return Dismissible(
                          key: Key(event.id.toString()),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) async {
                            final eventNotifier = ref.read(eventNotifierProvider.notifier);
                            await eventNotifier.removeEvent(event.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${event.title} dismissed')),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: EventCard(
                            title: event.title,
                            date: event.date.toIso8601String().split('T').first,
                            time: event.time,
                            location: event.location,
                            attendees: event.participants,
                          ),
                        );
                      },
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => const Center(child: Text('Error loading events')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
