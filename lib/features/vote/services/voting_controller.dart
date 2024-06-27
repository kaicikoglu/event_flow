import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data_models/voting_data_model.dart';
import '../../../services/vote_notifier.dart';


class VoteController {
  final TextEditingController topicNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  VoteController() {
    // Laden der Themen wird jetzt vom VoteNotifier gehandhabt
  }

  Future<void> addTopic(BuildContext context, WidgetRef ref, String topicName) async {
    if (topicName.isNotEmpty && topicName.length <= 10) {
      final newTopic = Vote()..name = topicName;
      ref.read(voteNotifierProvider.notifier).addVote(newTopic);
    }
  }

  void dispose() {
    topicNameController.dispose();
  }
}

final voteControllerProvider = Provider<VoteController>((ref) {
  return VoteController();
});