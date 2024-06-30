import 'package:event_flow/data_models/event_data_model.dart';
import 'package:event_flow/data_models/voting_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../services/event_list_provider.dart';
import '../../../services/voting_topic_list_provider.dart';
import '../../create_event/widgets/enter_text.dart';

class VotingController extends StateNotifier<List<VotingTopic>> {
  final Event event;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController topicNameController = TextEditingController();
  final TextEditingController optionNameController = TextEditingController();
  final TextEditingController optionNameController2 = TextEditingController();
  final TextEditingController textFields = TextEditingController();

  Future<void> handleSubmit(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      List<VoteOption> options = [];
      String topicName = topicNameController.text;
      options.add(VoteOption(label: optionNameController.text));
      options.add(VoteOption(label: optionNameController2.text));


      // ToDo Liste aus screen mit weiteren optionen durch gehen und in der liste speichern


      final votingTopic = VotingTopic()
        ..title = topicName
        ..createdDate = DateTime.now();

      final isar = IsarService().getIsar();

      await isar.writeTxn(() async {
        for (var option in options) {
          final voteOption = VoteOption(label: option.label, count: option.count)
            ..votingTopic.value = votingTopic;
          await isar.voteOptions.put(voteOption);
          votingTopic.options.add(voteOption);
        }
        await isar.votingTopics.put(votingTopic);
      });

      // Fügen Sie das VotingTopic zum Event hinzu
      event.votingTopics.add(votingTopic);

      // Speichern Sie das Event
      final topicNotifier = ref.read(votingTopicNotifierProvider.notifier);
      await topicNotifier.addVotingTopic(votingTopic);

      await event.createVotingTopic(isar, topicName, options);
      await loadTopics();


      printOptionData(await getOptionsForVotingTopicAndEvent(event, votingTopic));
      if (context.  mounted) {
        context.go('/vote_topic_screen', extra: {
          'event': event,
          'voting_title': topicName,
        });
      }
    }
  }


  VotingController(this.event) : super([]) {
    initialize();
  }

  Future<void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.votingTopics.load();
    state = event.votingTopics.toList();
  }
  Future<List<VoteOption>> getOptionsForVotingTopicAndEvent(Event event, VotingTopic votingTopic) async {
    // Laden Sie die VotingTopics des Events
    await event.votingTopics.load();

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

