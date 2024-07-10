import 'package:event_flow/data_models/event/event_data_model.dart';
import 'package:event_flow/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/vote/voting_topic_option_data_model.dart';
import '../../vote/services/vote_overview_provider.dart';
import '../widgets/enter_text.dart';

class CreateTopicController extends StateNotifier<List<VotingTopic>> {
  final Event event;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController topicNameController = TextEditingController();
  final TextEditingController optionNameController = TextEditingController();
  final TextEditingController optionNameController2 = TextEditingController();
  List<TextEditingController> additionalControllers = [];

  CreateTopicController(this.event) : super([]) {
    initialize();
  }

  Future<void> initialize() async {
    await IsarService().initializeIsar();
    await loadTopics();
  }

  Future<void> loadTopics() async {
    await event.votingTopics.load();
    state = event.votingTopics.toList();
  }

  double fieldWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = screenWidth * 0.5;
    double maxFieldWidth = 300;

    if (fieldWidth > maxFieldWidth) {
      fieldWidth = maxFieldWidth;
    }

    return fieldWidth;
  }

  void addTextField() {
    additionalControllers.add(TextEditingController());
  }

  List<Widget> getTextFields(BuildContext context) {
    final List<Widget> textFields = [
      EnterText(
        argument: 'Option:',
        hintText: 'Enter voting option',
        width: fieldWidth(context),
        height: 60,
        controller: optionNameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter option name';
          }
          return null;
        },
      ),
      EnterText(
        argument: 'Option:',
        hintText: 'Enter voting option',
        width: fieldWidth(context),
        height: 60,
        controller: optionNameController2,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter option name';
          }
          return null;
        },
      ),
    ];

    for (var controller in additionalControllers) {
      textFields.add(
        EnterText(
          argument: 'Option:',
          hintText: 'Enter voting option',
          width: fieldWidth(context),
          height: 60,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter option name';
            }
            return null;
          },
        ),
      );
    }

    return textFields;
  }

  Future<void> handleSubmit(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      List<VoteOption> options = [];
      String topicName = topicNameController.text;

      options.add(VoteOption()..label = optionNameController.text);
      options.add(VoteOption()..label = optionNameController2.text);

      for (var controller in additionalControllers) {
        options.add(VoteOption()..label = controller.text);
      }

      final isar = IsarService().getIsar();
      await event.createVotingTopic(isar, topicName, options);
      await loadTopics();

      ref
          .read(voteOverviewControllerProvider(event).notifier)
          .addTopic(VotingTopic()
        ..topicTitle = topicName
        ..options.addAll(options)
        ..event.value = event);

      if (context.mounted) {
        context.pop();
      }
    }
  }

  @override
  void dispose() {
    topicNameController.dispose();
    optionNameController.dispose();
    optionNameController2.dispose();
    for (var controller in additionalControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<List<VoteOption>> getOptionsForVotingTopicAndEvent(
      Event event, VotingTopic votingTopic) async {
    await event.votingTopics.load();

    if (event.votingTopics.contains(votingTopic)) {
      await votingTopic.options.load();

      return votingTopic.options.toList();
    } else {
      throw Exception(
          'The given VotingTopic does not belong to the VotingTopics of the Event');
    }
  }
}
