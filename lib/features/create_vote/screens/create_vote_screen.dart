import 'package:event_flow/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/wide_button.dart';
import '../../create_event/widgets/enter_text.dart';
import '../services/vote_create_topic_controller.dart';

class CreateVoteScreen extends ConsumerStatefulWidget {
  final Event event;

  const CreateVoteScreen({super.key, required this.event});

  @override
  _CreateVoteScreenState createState() => _CreateVoteScreenState();
}

class _CreateVoteScreenState extends ConsumerState<CreateVoteScreen> {
  late CreateTopicController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CreateTopicController(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = screenWidth * 0.5; // Set to 70% of screen width
    double maxFieldWidth = 300; // Maximum width

    if (fieldWidth > maxFieldWidth) {
      fieldWidth = maxFieldWidth;
    }

    return Padding(
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
                    hintText: 'Enter topic name',
                    width: fieldWidth,
                    height: 60,
                    controller: _controller.topicNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter topic name';
                      }
                      return null;
                    },
                  ),
                  ..._controller.getTextFields(context),
                  const SizedBox(height: 16),
                  CustomFAB(
                      onPressed: () => setState(() {
                            _controller.addTextField();
                          })),
                ],
              ),
            ),
            CustomWideButton(
              onPressed: () => _controller.handleSubmit(context, ref),
              text: 'Create Topic',
            ),
          ],
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


// final createTopicControllerProvider = StateNotifierProvider.family<
//     CreateTopicController, List<VotingTopic>, Event>((ref, event) {
//   return CreateTopicController(event);
// });
