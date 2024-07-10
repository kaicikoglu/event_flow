import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/data_models/todo/todo_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class TodoProvider extends StateNotifier<List<TodoTopic>> {
  final Event event;
  Set<int> selectedTopics = {};

  TodoProvider(this.event) : super([]) {
    initialize();
  }

  Future<void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.todoTopics.load();
    state = event.todoTopics.toList();
  }

  Future<void> addTopic(BuildContext context, String topicTitle) async {
    final isar = IsarService().getIsar();

    final existingTopic = await isar.todoTopics
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

    await event.createTodoTopic(isar, topicTitle);
    await loadTopics();
  }

  void toggleSelection(int topicId) {
    if (selectedTopics.contains(topicId)) {
      selectedTopics.remove(topicId);
    } else {
      selectedTopics.add(topicId);
    }
    // Force state update to refresh UI
    state = List.from(state);
  }

  bool isSelected(int topicId) {
    return selectedTopics.contains(topicId);
  }
}

final todoControllerProvider =
StateNotifierProvider.family<TodoProvider, List<TodoTopic>, Event>(
        (ref, event) {
      return TodoProvider(event);
    });
