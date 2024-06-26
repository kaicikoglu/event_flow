import 'package:isar/isar.dart';

import 'event_data_model.dart';

part 'voting_topic_data_model.g.dart';

@Collection()
class VotingTopic {
  Id id = Isar.autoIncrement;

  late String title;
  late DateTime createdDate;

  final event = IsarLink<Event>();
}
