import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:isar/isar.dart';

part 'voting_topic_option_data_model.g.dart';

@Collection()
class VoteOption {
  Id id = Isar.autoIncrement;

  late int eventId;
  late String label;
  late int count = 0;
  bool isSelected = false;

  final votingTopic = IsarLink<VotingTopic>();
}
