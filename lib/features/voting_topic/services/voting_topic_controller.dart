import 'package:event_flow/features/voting_topic/services/voting_topic_provider.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/vote/voting_topic_option_data_model.dart';

class VotingTopicController {
  final WidgetRef ref;

    // Überprüfen Sie, ob das gegebene VotingTopic zu den VotingTopics des Events gehört
    if (event.votingTopics.contains(votingTopic)) {
      // Laden Sie die Optionen des VotingTopics
      await votingTopic.options.load();

      // Geben Sie die Liste der Optionen zurück
      return votingTopic.options.toList();
    } else {
      // Werfen Sie einen Fehler, wenn das VotingTopic nicht zu den VotingTopics des Events gehört
      throw Exception('Das gegebene VotingTopic gehört nicht zu den VotingTopics des Events');
    }
  }
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

    // Laden Sie die Themen erneut, um den Zustand zu aktualisieren
    await loadTopics();
  }

  void printOptionData(List<VoteOption> options) {
    for (var option in options) {
      print('Option ID: ${option.id}');
      print('Option Label: ${option.label}');
      print('Option Count: ${option.count}');
      print('Option Is Selected: ${option.isSelected}');
      print('-------------------------');
    }
  }
  VotingTopic getCurrentTopic(String title){
    return state.firstWhere((element) => element.title == title);
  }
}

final voteTopicsControllerProvider =
    StateNotifierProvider.family<VotingController, List<VotingTopic>, Event>(
        (ref, event) {
  return VotingController(event);
});

