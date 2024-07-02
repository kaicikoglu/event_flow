// path: lib/features/forum_topic/screen/forum_topic_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/forum_topic_provider.dart';

class ForumTopicScreen extends ConsumerStatefulWidget {
  final int forumTopicId;

  const ForumTopicScreen({super.key, required this.forumTopicId});

  @override
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends ConsumerState<ForumTopicScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(forumTopicQuestionProvider.notifier)
        .loadQuestions(widget.forumTopicId);
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsyncValue = ref.watch(forumTopicQuestionProvider);
    final textController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: questionsAsyncValue.when(
                data: (questions) => ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return ListTile(
                      title: Text(question.question),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Enter your question',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      final questionText = textController.text;
                      if (questionText.isNotEmpty) {
                        ref
                            .read(forumTopicQuestionProvider.notifier)
                            .addQuestion(widget.forumTopicId, questionText);
                        textController
                            .clear(); // Clear the text field after sending
                      }
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
