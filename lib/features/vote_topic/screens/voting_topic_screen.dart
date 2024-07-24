import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/vote/voting_topic_option_data_model.dart';
import '../widgets/add_voting_option_button.dart';
import '../widgets/checkbox_wide_button.dart';
import '../services/voting_topic_controller.dart';
import '../services/voting_topic_provider.dart';

class VoteTopicScreen extends ConsumerStatefulWidget {
  final VotingTopic votingTopic;

  const VoteTopicScreen({super.key, required this.votingTopic});

  @override
  _VoteTopicScreenState createState() => _VoteTopicScreenState();
}

class _VoteTopicScreenState extends ConsumerState<VoteTopicScreen> {
  late VotingTopicController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VotingTopicController(ref);
    _controller.loadOptions(widget.votingTopic.id);
  }

  @override
  Widget build(BuildContext context) {
    final optionsAsyncValue = ref.watch(votingOptionsProvider);
    void addOption(String topicTitle) async {
      await _controller.addOption(topicTitle, widget.votingTopic);
    }

    void handleTap(VoteOption voteOption,AsyncValue<List<VoteOption>> options) async {
      List<VoteOption> optionsList = [];

      optionsAsyncValue.when(
        data: (options) {
          optionsList = options;
        },
        loading: () {
          // Behandeln des Ladens, z.B. durch Anzeigen eines Ladeindikators
        },
        error: (error, stack) {
          // Fehlerbehandlung, z.B. durch Anzeigen einer Fehlermeldung
        },
      );
        await _controller.toggleOption(optionsList,voteOption);
        // ref.refresh(votingOptionsProvider(widget.votingTopic.id)); // Refre
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.votingTopic.title,
                textAlign: TextAlign.center,// Anzeige des Titels des Abstimmungsthemas
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
                      onTap: () => handleTap(option,optionsAsyncValue),
                      borderColor: option.isSelected
                          ? Colors.green
                          : Colors.transparent, // Conditional border color
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
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddVotingOption(
                  votingTopic: widget.votingTopic,
                  ref: ref,
                  onOptionCreated: addOption,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
