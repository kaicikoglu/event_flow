import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/vote/voting_topic_option_data_model.dart';
import '../../vote/services/vote_overview_provider.dart';

final createTopicControllerProvider = StateNotifierProvider.family<
    CreateTopicController, List<VotingTopic>, Event>((ref, event) {
  return CreateTopicController(event);
});

class CreateTopicController extends StateNotifier<List<VotingTopic>> {
  final Event event;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController topicNameController = TextEditingController();
  final TextEditingController optionNameController = TextEditingController();
  final TextEditingController optionNameController2 = TextEditingController();

  Future<void> handleSubmit(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      List<VoteOption> options = [];
      String topicName = topicNameController.text;
      options.add(VoteOption()..label = optionNameController.text);
      options.add(VoteOption()..label = optionNameController2.text);

      final isar = IsarService().getIsar();
      await event.createVotingTopic(isar, topicName, options);
      await loadTopics();

      // Notify listeners about the new topic
      ref
          .read(voteOverviewControllerProvider(event).notifier)
          .addTopic(VotingTopic()
            ..topicTitle = topicName
            ..options.addAll(options)
            ..event.value = event);

      if (context.mounted) {
        context.pop();
      }
    }
  }

  CreateTopicController(this.event) : super([]) {
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

  Future<List<VoteOption>> getOptionsForVotingTopicAndEvent(
      Event event, VotingTopic votingTopic) async {
    await event.votingTopics.load();

    if (event.votingTopics.contains(votingTopic)) {
      await votingTopic.options.load();

      return votingTopic.options.toList();
    } else {
      throw Exception(
          'Das gegebene VotingTopic gehört nicht zu den VotingTopics des Events');
    }
  }

  void printOptionData(List<VoteOption> options) {
    for (var option in options) {
      print('Option ID: ${option.id}');
      print('Option Label: ${option.label}');
      print('Option Count: ${option.count}');
      print('-------------------------');
    }
  }
}
