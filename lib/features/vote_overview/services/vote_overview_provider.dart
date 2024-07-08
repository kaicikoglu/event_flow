import 'package:event_flow/data_models/event/event_data_model.dart';

import 'package:event_flow/data_models/forum/forum_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteOverviewController extends StateNotifier<List<ForumTopic>> {
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
    state = event.votingTopics.toList().cast<ForumTopic>();
  }
}

final voteOverviewControllerProvider =
StateNotifierProvider.family<VoteOverviewController, List<ForumTopic>, Event>(
        (ref, event) {
      return VoteOverviewController(event);
    });
