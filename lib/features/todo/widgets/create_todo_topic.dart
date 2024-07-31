import 'package:event_flow/features/todo/services/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';

class CreateTodoTopic extends StatefulWidget {
  final Function(String) onTopicCreated;
  final Event event;
  final WidgetRef ref;

  const CreateTodoTopic(
      {super.key,
      required this.onTopicCreated,
      required this.event,
      required this.ref});

  @override
  _CreateTodoTopic createState() => _CreateTodoTopic();
}

class _CreateTodoTopic extends State<CreateTodoTopic> {
  final TextEditingController _controller = TextEditingController();
  final TodoController _todoController = TodoController();

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
            const Text('Aufgabe erstellen', style: TextStyle(fontSize: 20.0)),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Geben Sie hier die Aufgabe ein",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final String topic = _controller.text;
                if (topic.length > 40){
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Fehler'),
                        content: const Text('Der Aufgabe darf maximal 40 Zeichen lang sein!'),
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
                }
                if (topic.isNotEmpty) {
                  widget.onTopicCreated(topic);
                  await _todoController.createAnnouncement(
                    context,
                    widget.ref,
                    widget.event,
                  );
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
