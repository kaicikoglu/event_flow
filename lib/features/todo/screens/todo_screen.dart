import 'package:event_flow/features/todo/widgets/checkbox_wide_button_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../services/todo_provider.dart';
import '../widgets/create_todo_topic.dart';

class ToDoScreen extends ConsumerWidget {
  final Event event;

  const ToDoScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(todoControllerProvider(event));
    final todoController = ref.read(todoControllerProvider(event).notifier);

    void addTopic(String topicTitle) async {
      await todoController.addTopic(ref.context, topicTitle);
    }

    return Scaffold(
      body: topics.isEmpty
          ? const Center(
        child: Text(
          'No topics yet. Be the first to create a topic!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          final isSelected = ref.watch(todoControllerProvider(event).notifier).isSelected(topic.id);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CheckboxWideButtonTodo(
              label: topic.title,
              isSelected: isSelected,
              onTap: () {
                todoController.toggleSelection(topic.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: CreateTodoTopic(
                  event: event,
                  ref: ref,
                  onTopicCreated: addTopic,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
