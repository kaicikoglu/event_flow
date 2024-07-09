import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteOverviewController extends StateNotifier<List<VotingTopic>> {
  final Event event;

  VoteOverviewController(this.event) : super([]) {
    initialize();
  }

  Future<void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.votingTopics.load();
    state = event.votingTopics.toList().cast<VotingTopic>();
  }
}

final voteOverviewControllerProvider = StateNotifierProvider.family<
    VoteOverviewController, List<VotingTopic>, Event>((ref, event) {
  return VoteOverviewController(event);
});
