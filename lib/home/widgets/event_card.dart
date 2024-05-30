import 'package:flutter/material.dart';
import '../../event/screens/event_screen.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String attendees;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventScreen(
              title: title,
              date: date,
              time: time,
              location: location,
              attendees: attendees,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Theme.of(context).primaryColorDark, width: 2.0), // Set the border color here
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(date)),
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(time)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(location)),
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Expanded(child: Text(attendees)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
