// lib/screens/home_content.dart
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
      selectedIndex: 0,
      child: Column(
        children: [
          SearchBar(
            hintText: 'Event Suchen...',
            controller: _searchController,
            onChanged: (value) {
              // Handle the search input here if needed
            },
          ),
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
