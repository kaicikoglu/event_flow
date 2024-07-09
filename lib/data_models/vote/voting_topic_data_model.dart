import 'package:event_flow/data_models/vote/voting_topic_option_data_model.dart';
import 'package:isar/isar.dart';

import '../event/event_data_model.dart';

part 'voting_topic_data_model.g.dart';

@Collection()
class VotingTopic {
  Id id = Isar.autoIncrement;
  late String topicTitle;
  late DateTime createdDate;
  final event = IsarLink<Event>();
  final options = IsarLinks<VoteOption>();
  bool _isSelected = false; // Hinzugefügtes privates Feld

  // Getter, der den aktuellen Wert von _isSelected zurückgibt
  bool get isSelected => _isSelected;

  // Methoden zum Ändern des Zustands
  void select() {
    _isSelected = true;
  }

  void deselect() {
    _isSelected = false;
  }
}


