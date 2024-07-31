import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/vote/voting_topic_option_data_model.dart';
import '../services/voting_topic_controller.dart';
import '../services/voting_topic_provider.dart';
import '../widgets/add_voting_option_button.dart';
import '../widgets/checkbox_wide_button.dart';

class VotingTopicScreen extends ConsumerStatefulWidget {
  final VotingTopic votingTopic;
  final BackButton? backButton;

  const VotingTopicScreen({super.key, required this.votingTopic, this.backButton});

  @override
  _VotingTopicScreenState createState() => _VotingTopicScreenState();
}

class _VotingTopicScreenState extends ConsumerState<VotingTopicScreen> {
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

    void handleTap(VoteOption voteOption) async {
      await _controller.toggleOption(voteOption);
    }

    return Scaffold(
      appBar: AppBar(
        leading: widget.backButton,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.votingTopic.title,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: optionsAsyncValue.when(
                data: (options) {
                  if (options.isEmpty) {
                    return const Center(
                      child: Text(
                        'Keine Optionen verfügbar',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return CheckboxWideButton(
                        label: option.label,
                        count: option.count,
                        isSelected: option.isSelected,
                        onTap: () => handleTap(option),
                        borderColor: option.isSelected
                            ? Colors.green
                            : Colors.transparent, // Conditional border color
                      );
                    },
                  );
                },
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
