// path: lib/features/home/screens/home_screen.dart

import 'package:event_flow/features/home/widgets/dismissible_event_card.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/home_provider.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsState = ref.watch(homeProvider);

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
            controller: _searchController,
            onChanged: (value) {
              ref.read(homeProvider.notifier).searchEvents(value);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final eventNotifier = ref.read(homeProvider.notifier);
                await eventNotifier.loadEvents();
              },
              child: eventsState.when(
                data: (events) {
                  if (events.isEmpty) {
                    return const Center(child: Text('No events found'));
                  } else {
                    events.sort((a, b) => a.date.compareTo(b.date));
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return DismissibleEventCard(event: event);
                      },
                    );
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    const Center(child: Text('Error loading events')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
