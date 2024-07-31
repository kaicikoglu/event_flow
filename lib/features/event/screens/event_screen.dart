import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/button_grid_view.dart';
import '../widgets/theme_button.dart';
import '../widgets/event_card_small.dart';  // Importiere EventCardSmall

class EventScreen extends StatelessWidget {
  final Event event;
  final BackButton? backButton;

  const EventScreen({
    super.key,
    required this.event,
    this.backButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton,
        title: Text(event.title),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EventCardSmall(event: event), // Ersetze die vorhandene Card durch EventCardSmall
            const SizedBox(height: 16),
            CustomWideButton(
              text: 'Teilnehmerliste bearbeiten',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Teilnehmerliste bald verfügbar')),
                );
              },
            ),
            const SizedBox(height: 8),
            CustomWideButton(
              text: 'Announcement',
              onPressed: () {
                context.push('/createAnnouncement', extra: event);
              },
            ),
            const SizedBox(height: 16),
            ButtonGridView(
              children: [
                ThemeButton(
                    icon: Icons.forum,
                    text: "Forum",
                    onPressed: () {
                      context.push('/forum', extra: event);
                    }),
                ThemeButton(
                    icon: Icons.how_to_vote,
                    text: "Vote-Area",
                    onPressed: () {
                      context.push('/vote', extra: event);
                    }),
                ThemeButton(
                    icon: Icons.cloud,
                    text: "Ressourcen",
                    onPressed: () {
                      context.push('/resources', extra: event);
                    }),
                ThemeButton(
                    icon: Icons.check_box,
                    text: "To-Dos",
                    onPressed: () {
                      context.push('/todo', extra: event);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
