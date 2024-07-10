import 'package:isar/isar.dart';

import '../event/event_data_model.dart';

part 'announcement_data_model.g.dart';

@Collection()
class Announcement {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late int eventId; // Reference to the event
  late String title; // Event title
  late DateTime sentDate; // Date the announcement is sent
  late String description; // Description of the announcement

  final event = IsarLink<Event>(); // Link to the parent Event
}
