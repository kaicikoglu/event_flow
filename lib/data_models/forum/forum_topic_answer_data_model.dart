import 'package:isar/isar.dart';

import 'forum_topic_question_data_model.dart';

part 'forum_topic_answer_data_model.g.dart';

@Collection()
class ForumTopicAnswer {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late int eventId;            // Reference to the event
  late String answer;

  final forumTopicQuestion =
      IsarLink<ForumTopicQuestion>(); // Link to the parent ForumTopicQuestion
}
