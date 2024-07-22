import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/data_models/vote/voting_topic_option_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';

final votingOptionsProvider = StateNotifierProvider<
    VotingTopicNotifier, AsyncValue<List<VoteOption>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return VotingTopicNotifier(isarService.getIsar());
});


class VotingTopicNotifier extends StateNotifier<AsyncValue<List<VoteOption>>> {
  // final IsarService isarService;
  final Isar _isar;

  VotingTopicNotifier(this._isar) : super(const AsyncValue.loading());

  Future<void> loadOptions(int votingTopicId) async {
    try {
      final votingTopics = await _isar.votingTopics.where().findAll();

      print("type of votingTopicid: ${votingTopicId.runtimeType}");

      VotingTopic? votingTopic;
      for (var topic in votingTopics) {
        print("type of saved votingTopicid: ${topic.id.runtimeType}");
        print("gesuchte ID:"+ votingTopicId.toString());
        print('Topic: ${topic.title}, ID: ${topic.id}');

        if (topic.id == votingTopicId) {
          votingTopic = topic;
          print('Topic: ${topic.title}, ID: ${topic.id}');
          print("Topic gefunden");
          break;
        }
      }
      if (votingTopic != null) {

        await votingTopic.options.load();
        var list = votingTopic.options.toList();
        state = AsyncValue.data(votingTopic.options.toList());

        if (list.isEmpty) {
          print('Keine VoteOptions vorhanden');
        } else {
          print('VoteOptions vorhanden');
        }

        // Zusätzliche Debug-Ausgaben
        print("Fertig Optionen laden:");
        for (var option in list) {
          print('Option: ${option.label}, ID: ${option.id}');
        }
      } else {
        print('Keine topic vorhanden');
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