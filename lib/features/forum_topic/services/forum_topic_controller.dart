// path: lib/features/forum_topic/controllers/forum_topic_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/forum_topic_provider.dart';

class ForumTopicController {
  final WidgetRef ref;

  ForumTopicController(this.ref);

  void loadQuestions(int forumTopicId) {
    ref.read(forumTopicQuestionProvider.notifier).loadQuestions(forumTopicId);
  }

  void addQuestion(int forumTopicId, String questionText) {
    ref.read(forumTopicQuestionProvider.notifier).addQuestion(forumTopicId, questionText);
  }

  void showAddQuestionModal(BuildContext context, int forumTopicId) {
    final textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your question',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    final questionText = textController.text;
                    if (questionText.isNotEmpty) {
                      addQuestion(forumTopicId, questionText);
                      Navigator.pop(context); // Close the modal after submitting
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
