import 'package:isar/isar.dart';

import '../event/event_data_model.dart';

part 'todo_data_model.g.dart';

@Collection()
class TodoTopic {
  Id id = Isar.autoIncrement; // Auto increment primary key
  late int eventId;
  late String title;
  late DateTime createdDate;

  final event = IsarLink<Event>(); // Link to the parent Event

}
