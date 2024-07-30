import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/data_models/vote/voting_topic_option_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../main.dart';

final votingOptionsProvider =
    StateNotifierProvider<VotingTopicNotifier, AsyncValue<List<VoteOption>>>(
        (ref) {
  final isarService = ref.watch(isarServiceProvider);
  return VotingTopicNotifier(isarService.getIsar());
});

class VotingTopicNotifier extends StateNotifier<AsyncValue<List<VoteOption>>> {
  final Isar _isar;

  VotingTopicNotifier(this._isar) : super(const AsyncValue.loading());

  Future<void> loadOptions(int votingTopicId) async {
    try {
      final votingTopic = await _isar.votingTopics.get(votingTopicId);
      if (votingTopic != null) {
        final votingOptions = await votingTopic.options.filter().findAll();
        state = AsyncValue.data(votingOptions.toList());
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addOption(BuildContext context, int votingTopicId,
      String optionLabel, int eventId) async {
    final voteOption = VoteOption()
      ..label = optionLabel
      ..count = 0
      ..votingTopicId = votingTopicId
      ..eventId = eventId;
    await _isar.writeTxn(() async {
      final votingTopic = await _isar.votingTopics.get(votingTopicId);
      if (votingTopic != null) {
        await _isar.voteOptions.put(voteOption);
        votingTopic.options.add(voteOption);
        await votingTopic.options.save();
      }
    });
    loadOptions(votingTopicId);
  }

  Future<void> toggleOption(VoteOption voteOption) async {
    await _isar.writeTxn(() async {
      if (voteOption.isSelected) {
        voteOption.count--;
      } else {
        voteOption.count++;
      }
      voteOption.isSelected = !voteOption.isSelected;

      await _isar.voteOptions.put(voteOption);
    });
    loadOptions(voteOption.votingTopicId);
  }
}
