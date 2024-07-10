import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../../create_event/widgets/enter_text.dart';
import '../services/vote_create_topic_controller.dart';

final createTopicControllerProvider = StateNotifierProvider.family<
    CreateTopicController, List<VotingTopic>, Event>((ref, event) {
  return CreateTopicController(event);
});

class CreateVoteScreen extends ConsumerStatefulWidget {
  final Event event;

  const CreateVoteScreen({super.key, required this.event});

  @override
  _CreateVoteScreenState createState() => _CreateVoteScreenState();
}

class _CreateVoteScreenState extends ConsumerState<CreateVoteScreen> {
  @override
  Widget build(BuildContext context) {
    final controllerNotifier =
        ref.read(createTopicControllerProvider(widget.event).notifier);
    final double fieldWidth = controllerNotifier.fieldWidth(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controllerNotifier.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  EnterText(
                    argument: 'Question:',
                    hintText: 'Enter topic name',
                    width: fieldWidth,
                    height: 60,
                    controller: controllerNotifier.topicNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter topic name';
                      }
                      return null;
                    },
                  ),
                  ...controllerNotifier.getTextFields(context),
                  const SizedBox(height: 16),
                  CustomFAB(
                      onPressed: () => setState(() {
                            controllerNotifier.addTextField();
                          })),
                ],
              ),
            ),
            CustomWideButton(
              onPressed: () => controllerNotifier.handleSubmit(context, ref),
              text: 'Create Topic',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    ref.read(createTopicControllerProvider(widget.event).notifier).dispose();
    super.dispose();
  }
}
