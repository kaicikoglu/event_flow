import 'package:flutter/material.dart';

import '../../../data_models/announcement/announcement_data_model.dart';
import '../services/announcements_controller.dart';
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
    return FutureBuilder<List<Announcement>>(
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
              final event =
                  _announcementController.getEventForAnnouncement(announcement);
              return AnnouncementWidget(
                  announcement: announcement, event: event);
            },
          );
        }
      },
    );
  }
}
