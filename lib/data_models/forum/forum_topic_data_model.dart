import 'package:isar/isar.dart';

import '../event/event_data_model.dart';
import 'forum_topic_question_data_model.dart';

part 'forum_topic_data_model.g.dart';

@Collection()
class ForumTopic {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String title;
  late DateTime createdDate;

  final event = IsarLink<Event>(); // Link to the parent Event
  final questions =
      IsarLinks<ForumTopicQuestion>(); // Link to ForumTopicQuestion

  // Method to create and save a forum topic question
  Future<void> createForumTopicQuestion(Isar isar, String questionText) async {
    final question = ForumTopicQuestion()
      ..question = questionText
      ..forumTopic.value = this;

    await isar.writeTxn(() async {
      await isar.forumTopicQuestions.put(question);
      questions.add(question);
      await questions.save();
    });
  }
}
