import 'package:isar/isar.dart';

import '../event/event_data_model.dart';

part 'voting_topic_data_model.g.dart';

@Collection()
class VotingTopic {
  Id id = Isar.autoIncrement;

  late String title;
  late DateTime createdDate;

  final event = IsarLink<Event>();
  final options = IsarLinks<VoteOption>();
}


@Collection()
class VoteOption {
  Id id = Isar.autoIncrement;
  late String label;
  late int count;
  bool isSelected = false;
  final votingTopic = IsarLink<VotingTopic>();

  VoteOption({required this.label, this.count = 0});
}