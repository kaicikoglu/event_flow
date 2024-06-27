// path: lib/services/isar_service.dart

import 'package:event_flow/data_models/announcement_data_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../data_models/event_data_model.dart';
import '../data_models/forum_topic_data_model.dart';
import '../data_models/voting_topic_data_model.dart';

class IsarService {
  static final IsarService _singleton = IsarService._internal();
  late Isar _isar;

  factory IsarService() {
    return _singleton;
  }

  IsarService._internal();

  Future<void> initializeIsar() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          EventSchema,
          AnnouncementSchema,
          ForumTopicSchema,
          VotingTopicSchema,
        ],
        directory: dir.path,
      );
    } else {
      _isar = Isar.getInstance()!;
    }
  }

  Isar getIsar() {
    return _isar;
  }

  Future<void> saveEvent(Event event) async {
    await _isar.writeTxn(() async {
      await _isar.events.put(event);
    });
  }

  Future<void> deleteEvent(int id) async {
    await _isar.writeTxn(() async {
      // Delete all announcements related to the event
      await _isar.announcements.filter().eventIdEqualTo(id).deleteAll();

      // Delete the event
      await _isar.events.delete(id);
    });
  }

  Future<List<Event>> getAllEvents() async {
    final events = await _isar.events.where().findAll();
    return events;
  }

  Future<void> announcementHasBeenChecked(Event event) async {
    await _isar.writeTxn(() async {
      event.hasNewAnnouncements = false;
      await _isar.events.put(event);
    });
  }
}
