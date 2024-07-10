import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';

final voteOverviewControllerProvider = StateNotifierProvider.family<
    VoteOverviewController, List<VotingTopic>, Event>((ref, event) {
  return VoteOverviewController(event);
});

class VoteOverviewController extends StateNotifier<List<VotingTopic>> {
  final Event event;

  VoteOverviewController(this.event) : super([]) {
    loadTopics();
  }

  Future<void> loadTopics() async {
    await event.votingTopics.load();
    state = event.votingTopics.toList();
  }

  void addTopic(VotingTopic topic) {
    state = [...state, topic];
  }
}
