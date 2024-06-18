import 'package:isar/isar.dart';

part 'event_data_model.g.dart';

@Collection()
class Event {
  Id id = Isar.autoIncrement;  // Auto increment primary key

  late String title;
  late DateTime date;
  late String time;
  late String location;
  late String participants;
}
