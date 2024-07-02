// path: lib/features/forum_topic/screen/answer_input.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/forum_topic_provider.dart';

class AnswerInput extends ConsumerWidget {
  final int questionId;

  const AnswerInput({Key? key, required this.questionId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter your answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onSubmitted: (answerText) {
              if (answerText.isNotEmpty) {
                ref.read(forumTopicQuestionProvider.notifier).addAnswer(questionId, answerText);
                textEditingController.clear();
              }
            },
          ),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () {
            final answerText = textEditingController.text;
            if (answerText.isNotEmpty) {
              ref.read(forumTopicQuestionProvider.notifier).addAnswer(questionId, answerText);
              textEditingController.clear(); // Clear the text field after sending
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
