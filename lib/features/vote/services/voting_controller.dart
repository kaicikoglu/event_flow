import 'package:event_flow/data_models/event_data_model.dart';
import 'package:event_flow/data_models/voting_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VotingController extends StateNotifier<List<VotingTopic>> {
  final Event event;

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

  Future<void> addTopic(String topicTitle) async {
    final isar = IsarService().getIsar();
    await event.createVotingTopic(isar, topicTitle);
    await loadTopics();
  }
}

final voteControllerProvider =
    StateNotifierProvider.family<VotingController, List<VotingTopic>, Event>(
        (ref, event) {
  return VotingController(event);
});
