import 'package:event_flow/data_models/forum/forum_topic_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data_models/forum/forum_topic_answer_data_model.dart';
import '../../../data_models/forum/forum_topic_question_data_model.dart';
import '../../../main.dart';

final forumTopicQuestionProvider = StateNotifierProvider<
    ForumTopicQuestionNotifier, AsyncValue<List<ForumTopicQuestion>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return ForumTopicQuestionNotifier(isarService.getIsar());
});

class ForumTopicQuestionNotifier
    extends StateNotifier<AsyncValue<List<ForumTopicQuestion>>> {
  final Isar _isar;

  ForumTopicQuestionNotifier(this._isar) : super(const AsyncValue.loading());

  Future<void> loadQuestions(int forumTopicId) async {
    try {
      final forumTopic = await _isar.forumTopics.get(forumTopicId);
      if (forumTopic != null) {
        final questions = await forumTopic.questions.filter().findAll();
        print("title: ${forumTopic.title}");
        print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");

        print('Questions: $questions');
        print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");


        for (var question in questions) {
          await question.answers.load();
        }

      } else {
        state = const AsyncValue.data([]);
        print(AsyncValue.data([]));
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }

    print('ready:');
    print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");

  }

  Future<void> addQuestion(
      BuildContext context, int forumTopicId, String questionText, int eventId) async {
    // Check if a forum topic with the same name already exists
    final existingQuestion = await _isar.forumTopicQuestions
        .filter()
        .questionEqualTo(questionText)
        .findFirst();

    if (existingQuestion != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Duplicate Question'),
            content:
                const Text('A forum topic with the same name already exists.'),
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

    final question = ForumTopicQuestion()
      ..question = questionText
      ..eventId = eventId;

    await _isar.writeTxn(() async {
      final forumTopic = await _isar.forumTopics.get(forumTopicId);
      if (forumTopic != null) {
        await _isar.forumTopicQuestions.put(question);
        forumTopic.questions.add(question);
        await forumTopic.questions.save();
      }
    });

    loadQuestions(forumTopicId);
  }

  Future<void> addAnswer(int questionId, String answerText, int eventId) async {
    final answer = ForumTopicAnswer()
      ..answer = answerText
      ..eventId = eventId;

    await _isar.writeTxn(() async {
      final question = await _isar.forumTopicQuestions.get(questionId);
      if (question != null) {
        await _isar.forumTopicAnswers.put(answer);
        question.answers.add(answer);
        await question.answers.save();

        // Directly update the state with the new answer
        state = state.whenData((questions) {
          final questionIndex = questions.indexWhere((q) => q.id == questionId);
          if (questionIndex != -1) {
            questions[questionIndex].answers.add(answer);
          }
          return questions;
        });
      }
    });
  }
}
