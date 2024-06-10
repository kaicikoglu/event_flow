import 'package:event_flow/event/widgets/button_grid_view.dart';
import 'package:event_flow/event/widgets/info_box.dart';
import 'package:event_flow/event/widgets/theme_button.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import '../../forum/screens/forum_screen.dart';
import '../../vote/screens/vote_screen.dart';
import '../../widgets/wide_button.dart';

class EventScreen extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String attendees;

  const EventScreen({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Text(title),
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
                            text1: date,
                            icon2: Icons.access_time,
                            text2: time)),
                    const SizedBox(height: 8),
                    Center(
                        child: InfoBox(
                            icon1: Icons.location_on,
                            text1: location,
                            icon2: Icons.person,
                            text2: attendees)),
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
                // Define your onPressed action here
              },
            ),
            const SizedBox(height: 16),
            ButtonGridView(
              children: [
                ThemeButton(
                    icon: Icons.forum,
                    text: "Forum",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForumScreen()));
                    }),
                ThemeButton(
                    icon: Icons.how_to_vote,
                    text: "Vote-Area",
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VoteScreen()));
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
