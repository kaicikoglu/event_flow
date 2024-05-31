import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:event_flow/home/widgets/search_bar.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/event_card.dart'; // Ensure this file exists with the EventCard widget

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: const Center(child: Text('Mein EventFlow')),
      selectedIndex: 0,
      floatingActionButton: CustomFAB(onPressed: () {
        // Handle the FAB press here
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Column(
        children: [
          CustomSearchBar(
              hintText: 'Suche nach Events',
              controller: _searchController,
              onChanged: (value) {
                // Handle the search bar input here
              }),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                EventCard(
                  title: 'Grillen am See',
                  date: '01.05.2024',
                  time: '17:00',
                  location: 'Herosé-Park',
                  attendees: '8/15',
                ),
                EventCard(
                  title: 'Campus Festival',
                  date: '10.05.2024',
                  time: '11:00',
                  location: 'Konstanz',
                  attendees: '13/20',
                ),
                EventCard(
                  title: 'Klassentreffen',
                  date: '15.05.2024',
                  time: '11:00',
                  location: 'Konstanz',
                  attendees: '13/30',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
