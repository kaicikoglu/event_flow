import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class AddVotingOption extends StatefulWidget {
  final Function(String) onOptionCreated;

  const AddVotingOption(
      {super.key,
      required this.onOptionCreated,
      required VotingTopic votingTopic,
      required WidgetRef ref});

  @override
  _AddVotingOptionState createState() => _AddVotingOptionState();
}

class _AddVotingOptionState extends State<AddVotingOption> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Antwortmöglichkeit hinzufügen',
              style: TextStyle(fontSize: 20.0)),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "Geben Sie hier eine Möglichkeit ein",
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async{
              final String option = _controller.text;
              if (option.length > 41) {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Fehler'),
                      content: const Text('Die Eingabe darf maximal 40 Zeichen lang sein!'),
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
              if (option.isNotEmpty) {
                widget.onOptionCreated(option);
                Navigator.pop(context);
              }
            },
            child: const Text('Antwortmöglichkeit erstellen'),
          ),
        ],
      ),
    );
  }
}
