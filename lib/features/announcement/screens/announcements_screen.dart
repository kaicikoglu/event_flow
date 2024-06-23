import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../data_models/announcement_data_model.dart';
import '../../../services/isar_service.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  late Future<List<Announcement>> _announcementsFuture;
  final IsarService _isarService = IsarService();

  @override
  void initState() {
    super.initState();
    _isarService.initializeIsar();
    _announcementsFuture = _fetchAnnouncements();
  }

  Future<List<Announcement>> _fetchAnnouncements() async {
    final isar = Isar.getInstance();
    if (isar == null) {
      throw Exception('Isar instance is not available');
    }
    return isar.announcements.where().findAll();
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
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(announcement.title),
                    subtitle: Text(
                      '${announcement.sentDate.toLocal().toString().split(' ')[0]} - ${announcement.description}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
