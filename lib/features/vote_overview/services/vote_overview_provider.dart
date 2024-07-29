import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';
import 'package:isar/isar.dart';
import 'package:event_flow/services/isar_service.dart';

class VoteOverviewProvider extends StateNotifier<List<VotingTopic>> {
  final Event event;

  VoteOverviewProvider(this.event) : super([]) {
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

  Future<void> addTopic(BuildContext context, String topicTitle) async {
    final isar = IsarService().getIsar();

    final existingTopic =
        await isar.votingTopics.filter().titleEqualTo(topicTitle).findFirst();
    if (existingTopic != null) {
      if (!context.mounted) return; // Check if the context is still mounted
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Topic schon vorhanden'),
            content: const Text(
                'Ein voting topic mit dem selben Titel gibt es bereits.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    await event.createVotingTopic(isar, topicTitle);
    await loadTopics();
  }
}

final voteOverviewProvider = StateNotifierProvider.family<VoteOverviewProvider,
    List<VotingTopic>, Event>((ref, event) {
  return VoteOverviewProvider(event);
});
