import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../create_vote/widgets/add_voting_option_button.dart';
import '../../create_vote/widgets/checkbox_wide_button.dart';
import '../services/voting_topic_controller.dart';
import '../services/voting_topic_provider.dart';

class VoteTopicScreen extends ConsumerStatefulWidget {
  final int votingTopicId;
  final BackButton? backButton;

  const VoteTopicScreen(
      {super.key, required this.votingTopicId, this.backButton});

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

  @override
  Widget build(BuildContext context) {
    final optionsAsyncValue = ref.watch(votingOptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting Topic'),
        centerTitle: true,
        leading: widget.backButton,
      ),
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
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) =>
                    const Center(child: Text('Ein Fehler ist aufgetreten')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFAB(
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
      ),
    );
  }
}
