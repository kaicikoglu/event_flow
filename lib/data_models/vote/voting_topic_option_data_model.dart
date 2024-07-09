import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:isar/isar.dart';

part 'voting_topic_option_data_model.g.dart';

@Collection()
class VoteOption {
  Id id = Isar.autoIncrement;
  late String label;
  late int count;
  bool isSelected = false;
  VoteOption({required this.label, this.count = 0});
  final votingTopic = IsarLink<VotingTopic>();
}