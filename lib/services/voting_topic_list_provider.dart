import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_models/event_data_model.dart';
import '../data_models/voting_topic_data_model.dart';
import '../main.dart';
import '../services/isar_service.dart';
class VotingTopicListProvider extends StateNotifier<AsyncValue<List<VotingTopic>>> {
  final IsarService isarService;

  VotingTopicListProvider(this.isarService) : super(const AsyncValue.loading()) {
    loadVotingTopics();
  }

  Future<void> loadVotingTopics() async {
    try {
      final votingTopics = await isarService.getAllVotingTopics();
      state = AsyncValue.data(votingTopics);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addVotingTopic(VotingTopic votingTopic) async {
    await isarService.saveVotingTopic(votingTopic);
    loadVotingTopics();
  }

  Future<void> removeVotingTopic(int id) async {
    await isarService.deleteVotingTopic(id);
    loadVotingTopics();
  }

  Future<void> updateVotingTopic(VotingTopic votingTopic) async {
    await isarService.saveVotingTopic(votingTopic);
    loadVotingTopics();
  }
}

final votingTopicNotifierProvider =
StateNotifierProvider<VotingTopicListProvider, AsyncValue<List<VotingTopic>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return VotingTopicListProvider(isarService);
});