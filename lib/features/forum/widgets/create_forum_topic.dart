import 'package:flutter/material.dart';

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
    return Padding(
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
            maxLength: 10,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final String topic = _controller.text;
              if (topic.isNotEmpty) {
                widget.onTopicCreated(topic);
                Navigator.pop(context);
              }
            },
            child: const Text('Bestätigen'),
          ),
        ],
      ),
    );
  }
}
