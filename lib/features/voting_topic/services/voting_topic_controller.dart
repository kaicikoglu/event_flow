import 'package:event_flow/features/voting_topic/services/voting_topic_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/vote/voting_topic_option_data_model.dart';

class VotingTopicController {
  final WidgetRef ref;

  VotingTopicController(this.ref);

  void loadOptions(int votingTopicId) {
    ref.read(votingOptionsProvider.notifier).loadOptions(votingTopicId);
  }

  Future<void> addOption(String optionLabel, VotingTopic topic) async {
    ref
        .read(votingOptionsProvider.notifier)
        .addOption(ref.context, topic.id, optionLabel, topic.eventId);

  }
  Future<void> toggleOption(List<VoteOption> options, VoteOption voteOption) async{
    int count = options.where((element) => element.isSelected).length;
    if (count == 0||count == 1 && voteOption.isSelected){
      ref
          .read(votingOptionsProvider.notifier)
          .toggleOption(voteOption);
    }
  }
}