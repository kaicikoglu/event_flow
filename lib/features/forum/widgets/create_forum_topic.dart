import 'package:event_flow/features/forum/services/forum_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';

class CreateForumTopic extends StatefulWidget {
  final Function(String) onTopicCreated;
  final Event event;
  final WidgetRef ref;

  const CreateForumTopic(
      {super.key,
      required this.onTopicCreated,
      required this.event,
      required this.ref});

  @override
  _CreateForumTopic createState() => _CreateForumTopic();
}

class _CreateForumTopic extends State<CreateForumTopic> {
  final TextEditingController _controller = TextEditingController();
  final ForumController _forumController = ForumController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Thema erstellen', style: TextStyle(fontSize: 20.0)),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Geben Sie hier Ihr Thema ein",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final String topic = _controller.text;
                if (topic.isNotEmpty) {
                  widget.onTopicCreated(topic);
                  await _forumController.createAnnouncement(
                      context, widget.ref, widget.event);
                }
              },
              child: const Text('Bestätigen'),
            ),
          ],
        ),
      ),
    );
  }
}
