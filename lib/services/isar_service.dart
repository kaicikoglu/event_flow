// path: lib/services/isar_service.dart

import 'dart:io';

import 'package:event_flow/data_models/announcement/announcement_data_model.dart';
import 'package:event_flow/data_models/forum/forum_topic_answer_data_model.dart';
import 'package:event_flow/data_models/forum/forum_topic_question_data_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../data_models/event/event_data_model.dart';
import '../data_models/forum/forum_topic_data_model.dart';
import '../data_models/pictures/picture_data_model.dart';
import '../data_models/vote/voting_topic_data_model.dart';
import '../data_models/vote/voting_topic_option_data_model.dart';

class IsarService {
  static final IsarService _singleton = IsarService._internal();
  late Isar _isar;

  factory IsarService() {
    return _singleton;
  }

  IsarService._internal();

  Future<void> initializeIsar() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          EventSchema,
          AnnouncementSchema,
          ForumTopicSchema,
          VotingTopicSchema,
          VoteOptionSchema,
          ForumTopicQuestionSchema,
          ForumTopicAnswerSchema,
          PictureSchema,
        ],
        directory: dir.path,
      );
    } else {
      _isar = Isar.getInstance()!;
    }
  }

  Isar getIsar() {
    return _isar;
  }

  Future<void> saveEvent(Event event) async {
    await _isar.writeTxn(() async {
      await _isar.events.put(event);
    });
  }

  Future<void> deleteEvent(int id) async {
    await _isar.writeTxn(() async {
      // Delete all announcements related to the event
      await _isar.announcements.filter().eventIdEqualTo(id).deleteAll();

      await _isar.forumTopicAnswers.filter().eventIdEqualTo(id).deleteAll();

      await _isar.forumTopicQuestions.filter().eventIdEqualTo(id).deleteAll();

      await _isar.forumTopics.filter().eventIdEqualTo(id).deleteAll();

      await _isar.votingTopics.filter().eventIdEqualTo(id).deleteAll();

      await _isar.voteOptions.filter().eventIdEqualTo(id).deleteAll();

      await _isar.pictures.filter().eventIdEqualTo(id).deleteAll();

      // Delete the event
      await _isar.events.delete(id);
    });
  }

  Future<List<Event>> getAllEvents() async {
    final events = await _isar.events.where().findAll();
    return events;
  }

  Future<void> announcementHasBeenChecked(Event event) async {
    await _isar.writeTxn(() async {
      event.hasNewAnnouncements = false;
      await _isar.events.put(event);
    });
  }

// Methode zum Speichern eines VotingTopic
  Future<void> saveVotingTopic(VotingTopic votingTopic) async {
    await _isar.writeTxn(() async {
      await _isar.votingTopics.put(votingTopic);
    });
  }

// Methode zum Löschen eines VotingTopic
  Future<void> deleteVotingTopic(int id) async {
    await _isar.writeTxn(() async {
      await _isar.votingTopics.delete(id);
    });
  }

// Methode zum Abrufen aller VotingTopics
  Future<List<VotingTopic>> getAllVotingTopics() async {
    final votingTopics = await _isar.votingTopics.where().findAll();
    return votingTopics;
  }

  Future<List<Picture>> getPicturesForEvent(Event event) async {
    return event.pictures.filter().findAll();
  }

  Future<void> deletePicture(Picture picture) async {
    final file = File(picture.imagePath);
    if (await file.exists()) {
      await file.delete();
    }

    await _isar.writeTxn(() async {
      await _isar.pictures.delete(picture.id);
    });
  }
}
