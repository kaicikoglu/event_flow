import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/voting_controller.dart'; // Importieren Sie den VoteController
class CreateTopicDialog extends ConsumerWidget {
  final TextEditingController topicNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: topicNameController,
              decoration: InputDecoration(
                labelText: 'Topic Name',
              ),
            ),
            ElevatedButton(
              child: Text('Add Topic'),
              onPressed: () {
                final voteController = ref.read(voteControllerProvider);
                voteController.addTopic(context, ref, topicNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}