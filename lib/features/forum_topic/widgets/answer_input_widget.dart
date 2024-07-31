import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/forum_topic_provider.dart';

class AnswerInput extends ConsumerWidget {
  final int questionId;
  final int eventId;

  const AnswerInput(
      {super.key, required this.questionId, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Antwort eingeben',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onSubmitted: (answerText) {
              if (answerText.isNotEmpty) {
                ref
                    .read(forumTopicQuestionProvider.notifier)
                    .addAnswer(questionId, answerText, eventId);
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
              ref
                  .read(forumTopicQuestionProvider.notifier)
                  .addAnswer(questionId, answerText, eventId);
              textEditingController
                  .clear(); // Clear the text field after sending
            }
          },
          child: const Text('Abschicken'),
        ),
      ],
    );
  }
}
