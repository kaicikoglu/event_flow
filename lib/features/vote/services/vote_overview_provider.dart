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
  Future <void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.votingTopics.load();
    state = event.votingTopics.toList();
  }

  void addTopic(VotingTopic topic) {
    state = [...state, topic];
  }
}

final voteOverviewControllerProvider = StateNotifierProvider.family<
    VoteOverviewProvider, List<VotingTopic>, Event>((ref, event) {
  return VoteOverviewProvider(event);
});