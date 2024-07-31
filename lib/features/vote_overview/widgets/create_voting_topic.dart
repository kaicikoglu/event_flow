import 'package:event_flow/features/vote_overview/services/vote_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';

class CreateVotingTopic extends StatefulWidget {
  final Function(String) onTopicCreated;
  final Event event;
  final WidgetRef ref;

  const CreateVotingTopic(
      {super.key,
      required this.onTopicCreated,
      required this.event,
      required this.ref});

  @override
  _CreateVotingTopic createState() => _CreateVotingTopic();
}

class _CreateVotingTopic extends State<CreateVotingTopic> {
  final TextEditingController _controller = TextEditingController();
  final VoteOverviewController _voteOverviewController =
      VoteOverviewController();

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
                if (topic.length > 40) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Fehler'),
                        content: const Text(
                            'Die Eingabe darf maximal 40 Zeichen lang sein!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else if (topic.isNotEmpty) {
                  widget.onTopicCreated(topic);
                  await _voteOverviewController.createAnnouncement(
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
