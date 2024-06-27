import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_models/voting_data_model.dart';
import '../main.dart';
import '../services/isar_service.dart';

class VoteNotifier extends StateNotifier<AsyncValue<List<Vote>>> {
  final IsarService isarService;

  VoteNotifier(this.isarService) : super(const AsyncValue.loading()) {
    loadVotes();
  }

  Future<void> addVote(Vote vote) async {
    print('addVote called'); // Debugging-Statement
    await isarService.saveVote(vote);
    print('Vote saved'); // Debugging-Statement
    await loadVotes();
  }

  Future<void> loadVotes() async {
    print('loadVotes called'); // Debugging-Statement
    try {
      final votes = await isarService.getAllVotes();
      state = AsyncValue.data(votes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeVote(int id) async {
    await isarService.deleteVote(id);
    loadVotes();
  }

  Future<void> updateVote(Vote vote) async {
    await isarService.saveVote(vote);
    loadVotes();
  }

  Future<void> searchVotes(String query) async {
    try {
      final votes = await isarService.getAllVotes();
      final filteredVotes = votes
          .where((vote) =>
          vote.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredVotes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final voteNotifierProvider =
StateNotifierProvider<VoteNotifier, AsyncValue<List<Vote>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return VoteNotifier(isarService);
});