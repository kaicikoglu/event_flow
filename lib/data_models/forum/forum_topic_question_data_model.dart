import 'package:isar/isar.dart';

import 'forum_topic_answer_data_model.dart';
import 'forum_topic_data_model.dart';

part 'forum_topic_question_data_model.g.dart';

@Collection()
class ForumTopicQuestion {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late int eventId; // Reference to the event
  late String question;

  final forumTopic = IsarLink<ForumTopic>(); // Link to the parent ForumTopic
  final answers = IsarLinks<ForumTopicAnswer>(); // Link to ForumTopicAnswer
}
