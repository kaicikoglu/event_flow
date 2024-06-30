import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateForumTopic extends StatefulWidget {
  final Function(String) onTopicCreated;

  const CreateForumTopic({super.key, required this.onTopicCreated});

  @override
  _CreateForumTopic createState() => _CreateForumTopic();
}

class _CreateForumTopic extends State<CreateForumTopic> {
  final TextEditingController _controller = TextEditingController();

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
              onPressed: () {
                final String topic = _controller.text;
                if (topic.isNotEmpty) {
                  widget.onTopicCreated(topic);
                  context.pop();
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
