import 'package:isar/isar.dart';

import '../../../data_models/announcement/announcement_data_model.dart';
import '../../../data_models/event/event_data_model.dart';
import '../../../services/isar_service.dart';

class AnnouncementController {
  final IsarService _isarService = IsarService();

  AnnouncementController() {
    _isarService.initializeIsar();
  }

  Future<List<Announcement>> fetchAnnouncements() async {
    final isar = Isar.getInstance();
    if (isar == null) {
      throw Exception('Isar instance is not available');
    }
    return isar.announcements.where().findAll();
  }

  Event getEventForAnnouncement(Announcement announcement) {
    final isar = Isar.getInstance();
    if (isar == null) {
      throw Exception('Isar instance is not available');
    }
    return isar.events.where().idEqualTo(announcement.eventId).findFirstSync()!;
  }
}
