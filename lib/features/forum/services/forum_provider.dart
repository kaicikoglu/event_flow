import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/data_models/forum/forum_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForumController extends StateNotifier<List<ForumTopic>> {
  final Event event;

  ForumController(this.event) : super([]) {
    initialize();
  }

  Future<void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.forumTopics.load();
    state = event.forumTopics.toList();
  }

  Future<void> addTopic(String topicTitle) async {
    final isar = IsarService().getIsar();
    await event.createForumTopic(isar, topicTitle);
    await loadTopics();
  }
}

final forumControllerProvider =
    StateNotifierProvider.family<ForumController, List<ForumTopic>, Event>(
        (ref, event) {
  return ForumController(event);
});
