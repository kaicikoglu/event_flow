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
  Future<void> createTodoTopic(Isar isar, String topicTitle) async {
    final todoTopic = TodoTopic()
      ..title = topicTitle
      ..createdDate = DateTime.now()
      ..eventId = id
      ..event.value = this;

    await isar.writeTxn(() async {
      await isar.todoTopics.put(todoTopic);
      todoTopics.add(todoTopic);
      await todoTopics.save();
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

  Future<VotingTopic> createVotingTopic(
      Isar isar, String votingTitle, Event event) async {
    final votingTopic = VotingTopic()
      ..eventId = event.id
      ..title = votingTitle
      ..createdDate = DateTime.now()
      ..event.value = event;

    await isar.writeTxn(() async {
      await isar.votingTopics.put(votingTopic);
    });

    print("VotingTopic wurde erfolgreich gespeichert: ${votingTopic.title}");
    return votingTopic;
  }

  Future<List<VoteOption>> addVoteOptions(Isar isar, VotingTopic topic,
      List<String> optionLabels, Event event) async {
    List<VoteOption> voteOptions = [];

    for (var label in optionLabels) {
      final voteOption = VoteOption()
        ..label = label
        ..count = 0
        ..topicID = topic.id
        ..votingTopicId = topic.id;

      voteOptions.add(voteOption);
    }

    await isar.writeTxn(() async {
      await isar.voteOptions.putAll(voteOptions);
      topic.options.addAll(voteOptions);
      await topic.options.save();
    });

    // Optionale Überprüfung, ob die VoteOptions erfolgreich gespeichert wurden
    var savedVotingTopic = await isar.votingTopics.get(topic.id);
    if (savedVotingTopic != null) {
      await savedVotingTopic.options.load();
      if (savedVotingTopic.options.isNotEmpty) {
        print("Folgende VoteOptions wurden gespeichert:");
        for (var option in savedVotingTopic.options) {
          print("Option: ${option.label}, Count: ${option.count}");
        }
        return savedVotingTopic.options
            .toList(); // Zurückgeben der gespeicherten Liste
      } else {
        print("Keine VoteOptions wurden gespeichert.");
      }
    } else {
      print("Fehler: VotingTopic wurde nicht gespeichert.");
    }
    return []; // Leere Liste zurückgeben, wenn keine Optionen gespeichert wurden oder ein Fehler aufgetreten ist
  }

  // Method to create and save a voting topic
  // Future<void> createVotingandoptionsTopic(
  //     Isar isar, String votingTitle, List<VoteOption> options,Event event) async {
  //
  //   final votingTopic = VotingTopic()
  //     ..eventId = event.id
  //     ..title = votingTitle
  //     ..createdDate = DateTime.now()
  //     ..event.value = event;
  //
  //   List<VoteOption> voteOptions = [];
  //
  //   for (var option in options) {
  //     final voteOption = VoteOption()
  //       ..votingTopicId = votingTopic.id
  //       ..label = option.label
  //       ..count = 0
  //       ..votingTopic.value = votingTopic;
  //     voteOptions.add(voteOption);
  //   }
  //   votingTopic.options.addAll(voteOptions);
  //
  //   await isar.writeTxn(() async {
  //     await isar.votingTopics.put(votingTopic);
  //     await isar.voteOptions.putAll(voteOptions);
  //     // votingTopics.add(votingTopic);
  //     // voteOptions.addAll(voteOptions);
  //     // Überprüfen, ob das VotingTopic und die VoteOptions korrekt gespeichert wurden
  //     var savedVotingTopic = await isar.votingTopics.get(votingTopic.id);
  //     if (savedVotingTopic != null) {
  //       print("VotingTopic wurde erfolgreich gespeichert: ${savedVotingTopic.title}");
  //       // Laden der Optionen des gespeicherten Topics
  //       await savedVotingTopic.options.load();
  //       if (savedVotingTopic.options.isNotEmpty) {
  //         print("Folgende VoteOptions wurden gespeichert:");
  //         for (var option in savedVotingTopic.options) {
  //           print("Option: ${option.label}, Count: ${option.count}");
  //         }
  //       } else {
  //         print("Keine VoteOptions wurden gespeichert.");
  //       }
  //     } else {
  //       print("Fehler: VotingTopic wurde nicht gespeichert.");
  //     }
  //     print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");
  //
  //   } as Future Function());
  //   print("Data saved successfully.");
  // }

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
