import 'package:isar/isar.dart';

import '../event/event_data_model.dart';

part 'picture_data_model.g.dart';

@Collection()
class Picture {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String imagePath; // Path to the image file
  late DateTime uploadDate;

  final event = IsarLink<Event>(); // Link to the parent event
}
