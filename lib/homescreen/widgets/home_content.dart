import 'package:flutter/material.dart';
import 'event_card.dart'; // Make sure to create this file for the EventCard widget

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Event Suchen...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
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
