import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/button_grid_view.dart';
import '../widgets/info_box.dart';
import '../widgets/theme_button.dart';

class EventScreen extends StatelessWidget {
  final Event? event;

  const EventScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Text(event!.title),
      selectedIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                    color: Color.fromRGBO(73, 81, 86, 100), width: 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                        child: InfoBox(
                            icon1: Icons.calendar_today,
                            text1:
                                event!.date.toIso8601String().split('T').first,
                            icon2: Icons.access_time,
                            text2: event!.time)),
                    const SizedBox(height: 8),
                    Center(
                        child: InfoBox(
                            icon1: Icons.location_on,
                            text1: event!.location,
                            icon2: Icons.person,
                            text2: event!.participants)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomWideButton(
              text: 'Teilnehmerliste bearbeiten',
              onPressed: () {},
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
                    icon: Icons.cloud, text: "Ressourcen", onPressed: () {}),
                ThemeButton(
                    icon: Icons.check_box, text: "To-Dos", onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
