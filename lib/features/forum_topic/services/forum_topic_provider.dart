// path: lib/features/forum_topic/services/forum_topic_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../data_models/forum_topic_question_data_model.dart';
import '../../../main.dart';

final forumTopicQuestionProvider = StateNotifierProvider<ForumTopicQuestionNotifier, AsyncValue<List<ForumTopicQuestion>>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return ForumTopicQuestionNotifier(isarService.getIsar());
});

class ForumTopicQuestionNotifier extends StateNotifier<AsyncValue<List<ForumTopicQuestion>>> {
  final Isar _isar;

  ForumTopicQuestionNotifier(this._isar) : super(const AsyncValue.loading());

  Future<void> loadQuestions(int forumTopicId) async {
    try {
      final questions = await _isar.forumTopicQuestions.filter().idEqualTo(forumTopicId).findAll();
      state = AsyncValue.data(questions);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addQuestion(int forumTopicId, String questionText) async {
    final question = ForumTopicQuestion()
      ..id = forumTopicId
      ..question = questionText;

    await _isar.writeTxn(() async {
      await _isar.forumTopicQuestions.put(question);
    });

    loadQuestions(forumTopicId); // Reload questions after adding
  }
}
