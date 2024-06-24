// path: lib/screens/announcement_screen.dart

import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import '../../../data_models/announcement_data_model.dart';
import '../services/announcements_screen_controller.dart';
import '../widgets/announcement_widget.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late Future<List<Announcement>> _announcementsFuture;
  final AnnouncementController _announcementController =
      AnnouncementController();

  @override
  void initState() {
    super.initState();
    _announcementsFuture = _announcementController.fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: const Text('Announcements'),
      selectedIndex: 1,
      child: FutureBuilder<List<Announcement>>(
        future: _announcementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No announcements available'));
          } else {
            final announcements = snapshot.data!;
            return ListView.builder(
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                final event = _announcementController.getEventForAnnouncement(
                    announcement); // Implement this method to get the event for each announcement
                return AnnouncementWidget(
                    announcement: announcement, event: event);
              },
            );
          }
        },
      ),
    );
  }
}