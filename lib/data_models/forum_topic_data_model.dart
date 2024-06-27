import 'package:isar/isar.dart';
import 'event_data_model.dart';

part 'forum_topic_data_model.g.dart';

@Collection()
class ForumTopic {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String title;
  late DateTime createdDate;

  final event = IsarLink<Event>(); // Link to the parent event
}
