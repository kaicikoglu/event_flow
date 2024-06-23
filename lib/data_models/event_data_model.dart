import 'package:isar/isar.dart';

import 'announcement_data_model.dart';

part 'event_data_model.g.dart';

@Collection()
class Event {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String title;
  late DateTime date;
  late String time;
  late String location;
  late String participants;

  final announcements = IsarLinks<Announcement>(); // Link to announcements

  // Method to create and save an announcement
  Future<void> createAnnouncement(Isar isar, String description) async {
    final announcement = Announcement()
      ..eventId = id
      ..title = title
      ..sentDate = DateTime.now()
      ..description = description;

    await isar.writeTxn(() async {
      await isar.announcements.put(announcement);
      announcements.add(announcement);
      await announcements.save();
    } as Future Function());
  }
}
