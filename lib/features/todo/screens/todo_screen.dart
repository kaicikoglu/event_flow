import 'package:event_flow/features/forum/widgets/create_forum_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../services/todo_provider.dart';

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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomWideButton(
              text: topics[index].title,
              onPressed: () {
                context.push('/forumTopic', extra: topics[index]);
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
                child: CreateForumTopic(
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
