import 'package:flutter/material.dart';

class CreateVotingTopic extends StatefulWidget {
  final Function(String) onTopicCreated;

  const CreateVotingTopic({super.key, required this.onTopicCreated});

  @override
  _CreateVotingTopic createState() => _CreateVotingTopic();
}

class _CreateVotingTopic extends State<CreateVotingTopic> {
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
