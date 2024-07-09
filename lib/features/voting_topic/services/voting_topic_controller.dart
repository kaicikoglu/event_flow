import 'package:event_flow/features/voting_topic/services/voting_topic_provider.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/vote/voting_topic_option_data_model.dart';

class VotingTopicController {
  final WidgetRef ref;

  VotingTopicController(this.ref);

  void loadOptions(int votingTopicId) {
    ref.read(votingOptionsProvider.notifier).loadOptions(votingTopicId);
  }
  // Methode zum Hinzufügen einer neuen Option zu einem VotingTopic
  Future<void> addOption(String optionLabel, VotingTopic topic) async {

    final isar = IsarService().getIsar();

    await isar.writeTxn(() async {
      // Erstellen Sie ein neues VoteOption-Objekt
      final option = VoteOption(label: optionLabel);

      // Fügen Sie das neue VoteOption-Objekt zur Liste der Optionen in dem VotingTopic hinzu
      topic.options.add(option);

      // Aktualisieren Sie das VotingTopic in der Datenbank
      await isar.votingTopics.put(topic);
    });
  }
}