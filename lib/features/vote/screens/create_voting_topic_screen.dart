import 'package:event_flow/features/vote/widgets/create_voting_topic.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../data_models/voting_topic_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../services/voting_controller.dart';
import '../widgets/enter_text.dart';


class CreateVotingTopicScreen extends ConsumerStatefulWidget {
  final Event event;
  // final VotingTopic? topic;

  const CreateVotingTopicScreen({super.key, required this.event});

  @override
  _CreateVotingTopicScreenState createState() => _CreateVotingTopicScreenState();
}

class _CreateVotingTopicScreenState extends ConsumerState<CreateVotingTopicScreen> {
  late VotingController _controller = VotingController(widget.event);
  List<Widget> textFields = [];

  void addTextField() {
    setState(() {
      textFields.add(
        EnterText(
          argument: 'Option:',
          hintText: 'Enter voting option',
          width: 250,
          height: 60,
          controller: TextEditingController(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter option name';
            }
            return null;
          },
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final voteController = ref.read(voteTopicsControllerProvider(widget.event).notifier);

    return BaseScreen(
      selectedIndex: 0,
      title: Text(widget.event != null ? 'Edit Voting' : 'Create Voting'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    EnterText(
                      argument: 'Question:',
                      hintText: 'Enter event name',
                      width: 250,
                      height: 60,
                      controller: _controller.topicNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event name';
                        }
                        return null;
                      },
                      updateText: widget.event?.title,
                    ),
                    EnterText(
                      argument: 'Option:',
                      hintText: 'Enter voting option',
                      width: 250,
                      height: 60,
                      controller: _controller.optionNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter topic name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    EnterText(
                      argument: 'Option:',
                      hintText: 'Enter voting option',
                      width: 250,
                      height: 60,
                      controller: _controller.optionNameController2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter topic name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ...textFields
                  ]
                ),
              ),

              FloatingActionButton(
                onPressed: addTextField,
                child: Icon(Icons.add),
              ),
              CustomWideButton(
                // text: widget.topic != null ? 'Update Topic' : 'Create Topic',
                onPressed: () => _controller.handleSubmit(context, ref), text: 'Create Topic',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
