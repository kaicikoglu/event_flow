// path: lib/features/forum_topic/services/forum_topic_provider.dart

import 'package:event_flow/data_models/forum_topic_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data_models/forum_topic_question_data_model.dart';
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
        state = AsyncValue.data(questions);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addQuestion(int forumTopicId, String questionText) async {
    final question = ForumTopicQuestion()..question = questionText;

    await _isar.writeTxn(() async {
      final forumTopic = await _isar.forumTopics.get(forumTopicId);
      if (forumTopic != null) {
        await _isar.forumTopicQuestions.put(question);
        forumTopic.questions.add(question);
        await forumTopic.questions.save();
      }
    });

    loadQuestions(forumTopicId); // Reload questions after adding
  }
}
