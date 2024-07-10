import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/data_models/vote/voting_topic_option_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';

final votingOptionsProvider = StateNotifierProvider<
    VotingTopicProvider, AsyncValue<List<VoteOption>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return VotingTopicProvider(IsarService(),isarService.getIsar());
});


class VotingTopicProvider extends StateNotifier<AsyncValue<List<VoteOption>>> {
  final IsarService isarService;
  final Isar _isar;


  VotingTopicProvider(this.isarService,this._isar) : super(const AsyncValue.loading());

  Future<void> loadOptions(int votingTopicId) async {
    try {
      final votingTopic = await _isar.votingTopics.get(votingTopicId);
      if (votingTopic != null) {

        await votingTopic.options.load();
        state = AsyncValue.data(votingTopic.options.toList());
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      print('Fehler beim Laden der VoteOptions: $e');
    }
  }

  Future<List<VoteOption>> getOptionsForVotingTopic(int votingTopicId) async {
    try {
      final votingTopic = await _isar.votingTopics.get(votingTopicId);
      if (votingTopic != null) {
        // Lädt alle VoteOptions, die zu diesem VotingTopic gehören
        await votingTopic.options.load();
        // Konvertiert das Iterable in eine Liste
        return votingTopic.options.toList();
      } else {
        return [];
      }
    } catch (e) {
      // Fehlerbehandlung oder Logging könnte hier erfolgen
      return [];
    }
  }
}






// class VotingTopicNotifier extends StateNotifier<AsyncValue<List<VotingTopic>>> {
//   final Isar _isar;
//
//   VotingTopicNotifier(this._isar) : super(const AsyncValue.loading());
//
//   Future<void> loadTopics(int votingTopicId) async {
//     try {
//       final votingTopics = await _isar.votingTopics.get(votingTopicId);
//       if (votingTopics != null) {
//         state = AsyncValue.data([votingTopics]);
//       } else {
//         state = const AsyncValue.data([]);
//       }
//     } catch (e) {
//       state = AsyncValue.error(e, StackTrace.current);
//     }
//   }
//   Future<VotingTopic?> getCurrentTopic(int votingTopicId) async {
//     try {
//       final votingTopic = await _isar.votingTopics.get(votingTopicId);
//       return votingTopic;
//     } catch (e) {
//       // Fehlerbehandlung oder Logging könnte hier erfolgen
//       return null;
//     }
//   }
//   Future<List<VoteOption>> getOptionsForVotingTopic(int votingTopicId) async {
//     try {
//       final votingTopic = await _isar.votingTopics.get(votingTopicId);
//       if (votingTopic != null) {
//         // Lädt alle VoteOptions, die zu diesem VotingTopic gehören
//         await votingTopic.options.load();
//         // Konvertiert das Iterable in eine Liste
//         return votingTopic.options.toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       // Fehlerbehandlung oder Logging könnte hier erfolgen
//       return [];
//     }
//   }
// }

// final votingTopicProvider =
// StateNotifierProvider<VotingTopicNotifier, AsyncValue<List<VotingTopic>>>(
//         (ref) {
//       final isarService = ref.watch(isarServiceProvider);
//       return VotingTopicNotifier(isarService.getIsar());
//     });