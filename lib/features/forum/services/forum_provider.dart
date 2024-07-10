import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/data_models/forum/forum_topic_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class ForumProvider extends StateNotifier<List<ForumTopic>> {
  final Event event;

  ForumProvider(this.event) : super([]) {
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

  Future<void> addTopic(BuildContext context, String topicTitle) async {
    final isar = IsarService().getIsar();

    // Check if a forum topic with the same title already exists
    final existingTopic = await isar.forumTopics
        .filter()
        .titleEqualTo(topicTitle)
        .findFirst();

    if (existingTopic != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Duplicate Topic'),
            content: const Text('A forum topic with the same title already exists.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    await event.createForumTopic(isar, topicTitle);
    await loadTopics();
  }
}

final forumControllerProvider =
    StateNotifierProvider.family<ForumProvider, List<ForumTopic>, Event>(
        (ref, event) {
  return ForumProvider(event);
});
