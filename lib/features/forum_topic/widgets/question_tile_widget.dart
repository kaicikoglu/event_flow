import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/forum/forum_topic_question_data_model.dart';
import '../services/forum_topic_provider.dart';
import 'answer_input_widget.dart';

class QuestionTile extends ConsumerWidget {
  final ForumTopicQuestion question;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;

  const QuestionTile({
    super.key,
    required this.question,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(forumTopicQuestionProvider);

    final updatedQuestion = questionState.when(
      data: (questions) => questions.firstWhere((q) => q.id == question.id,
          orElse: () => question),
      loading: () => question,
      error: (_, __) => question,
    );

    return ExpansionTile(
      key: Key(updatedQuestion.id.toString()),
      title: Text(updatedQuestion.question),
      onExpansionChanged: onExpansionChanged,
      initiallyExpanded: isExpanded,
      children: [
        ...updatedQuestion.answers
            .map((answer) => ListTile(title: Text(answer.answer))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnswerInput(
            questionId: updatedQuestion.id,
            eventId: question.eventId,
          ),
        ),
      ],
    );
  }
}
