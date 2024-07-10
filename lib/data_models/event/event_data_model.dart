import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:isar/isar.dart';

import '../announcement/announcement_data_model.dart';
import '../forum/forum_topic_data_model.dart';
import '../pictures/picture_data_model.dart';
import '../todo/todo_data_model.dart';
import '../vote/voting_topic_option_data_model.dart';

part 'event_data_model.g.dart';

@Collection()
class Event {
  Id id = Isar.autoIncrement; // Auto increment primary key

  late String title;
  late DateTime date;
  late String time;
  late String location;
  late String participants;

  final announcements = IsarLinks<Announcement>(); // Link to announcements
  final forumTopics = IsarLinks<ForumTopic>(); // Link to forum topics
  final votingTopics = IsarLinks<VotingTopic>(); // Link to voting topics
  final todoTopics = IsarLinks<TodoTopic>(); // Link to todo topics
  final pictures = IsarLinks<Picture>(); // Link to pictures
  bool hasNewAnnouncements = false;

  // Method to create and save an announcement
  Future<void> createAnnouncement(Isar isar, String description) async {
    final announcement = Announcement()
      ..eventId = id
      ..title = title
      ..sentDate = DateTime.now()
      ..description = description;

    await isar.writeTxn(() async {
      await isar.announcements.put(announcement);
      announcements.add(announcement);
      hasNewAnnouncements = true;
      await announcements.save();
    } as Future Function());
  }

  // Method to create and save a forum topic
  Future<void> createForumTopic(Isar isar, String topicTitle) async {
    final forumTopic = ForumTopic()
      ..eventId = id
      ..title = topicTitle
      ..createdDate = DateTime.now()
      ..event.value = this;

    await isar.writeTxn(() async {
      await isar.forumTopics.put(forumTopic);
      forumTopics.add(forumTopic);
      await forumTopics.save();
    } as Future Function());
  }

  // Method to create and save a voting topic
  Future<void> createVotingTopic(
      Isar isar, String votingTitle, List<VoteOption> options) async {
    final votingTopic = VotingTopic()
      ..topicTitle = votingTitle
      ..createdDate = DateTime.now()
      ..eventId = id;

    await isar.writeTxn(() async {
      for (var option in options) {
        final voteOption = VoteOption()
          ..eventId = id
          ..label = option.label
          ..count = option.count
          ..votingTopic.value = votingTopic;
        await isar.voteOptions.put(voteOption);
        votingTopic.options.add(voteOption);
      }
      await isar.votingTopics.put(votingTopic);
      votingTopics.add(votingTopic);
      await votingTopics.save();
    } as Future Function());
  }

  // Method to create and save a picture
  Future<void> createPicture(Isar isar, String imagePath) async {
    final picture = Picture()
      ..imagePath = imagePath
      ..uploadDate = DateTime.now()
      ..eventId = id
      ..event.value = this;

    await isar.writeTxn(() async {
      await isar.pictures.put(picture);
      pictures.add(picture);
      await pictures.save();
    } as Future Function());
  }
}
