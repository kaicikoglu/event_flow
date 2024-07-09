import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../vote_create_topic/widgets/add_voting_option_button.dart';
import '../../vote_create_topic/widgets/checkbox_wide_button.dart';
import '../services/voting_topic_controller.dart';
import '../services/voting_topic_provider.dart';


class VoteTopicScreen extends ConsumerStatefulWidget {
  final int votingTopicId;

  const VoteTopicScreen({
    Key? key, required this.votingTopicId
  }) : super(key: key);

  @override
  _VoteTopicScreenState createState() => _VoteTopicScreenState();
}

class _VoteTopicScreenState extends ConsumerState<VoteTopicScreen> {
  late VotingTopicController _controller;


  @override
  void initState() {
    super.initState();
    _controller = VotingTopicController(ref);
    _controller.loadOptions(widget.votingTopicId);
  }

  Widget build(BuildContext context) {
    final optionsAsyncValue = ref.watch(votingOptionsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: optionsAsyncValue.when(
                data: (options) => ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return CheckboxWideButton(
                      label: option.label,
                      count: option.count,
                      isSelected: option.isSelected,
                      onTap: () {
                        // Implementieren Sie die Logik, um die Auswahl zu speichern
                      },
                    );
                  },
                ),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Ein Fehler ist aufgetreten')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddVotingOption(onOptionCreated: (optionLabel) {
                // Implementieren Sie die Logik, um eine neue Option hinzuzufügen
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}