// import 'package:event_flow/data_models/event/event_data_model.dart';
// import 'package:event_flow/services/isar_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../data_models/vote/voting_topic_data_model.dart';
// import '../../../data_models/vote/voting_topic_option_data_model.dart';
//
// class CreateTopicController extends StateNotifier<List<VotingTopic>> {
//   final Event event;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController topicNameController = TextEditingController();
//   final TextEditingController optionNameController = TextEditingController();
//   final TextEditingController optionNameController2 = TextEditingController();
//   List<TextEditingController> additionalControllers = [];
//
//   CreateTopicController(this.event) : super([]) {
//     initialize();
//   }
//
//   Future<void> initialize() async {
//     await IsarService().initializeIsar();
//     await loadTopics();
//   }
//
//   Future<void> loadTopics() async {
//     await event.votingTopics.load();
//     state = event.votingTopics.toList();
//   }
//
//   double fieldWidth(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double fieldWidth = screenWidth * 0.5;
//     double maxFieldWidth = 300;
//
//     if (fieldWidth > maxFieldWidth) {
//       fieldWidth = maxFieldWidth;
//     }
//
//     return fieldWidth;
//   }
//
//   void addTextField() {
//     additionalControllers.add(TextEditingController());
//   }
//
//   List<Widget> getTextFields(BuildContext context) {
//     final List<Widget> textFields = [
//       EnterText(
//         argument: 'Option:',
//         hintText: 'Enter voting option',
//         width: fieldWidth(context),
//         height: 60,
//         controller: optionNameController,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter option name';
//           }
//           return null;
//         },
//       ),
//       EnterText(
//         argument: 'Option:',
//         hintText: 'Enter voting option',
//         width: fieldWidth(context),
//         height: 60,
//         controller: optionNameController2,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter option name';
//           }
//           return null;
//         },
//       ),
//     ];
//
//     for (var controller in additionalControllers) {
//       textFields.add(
//         EnterText(
//           argument: 'Option:',
//           hintText: 'Enter voting option',
//           width: fieldWidth(context),
//           height: 60,
//           controller: controller,
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter option name';
//             }
//             return null;
//           },
//         ),
//       );
//     }
//
//     return textFields;
//   }
//
//   // Future<void> handleSubmit(BuildContext context, WidgetRef ref) async {
//   //   final isar = IsarService().getIsar();
//   //
//   //   if (formKey.currentState!.validate()) {
//   //     List<String> optionNames = [];
//   //     String topicName = topicNameController.text;
//   //
//   //     optionNames.add(optionNameController.text);
//   //     optionNames.add(optionNameController2.text);
//   //
//   //     for (var controller in additionalControllers) {
//   //       optionNames.add(controller.text);
//   //     }
//   //     for (var o in optionNames) {
//   //       print("label: "+o);
//   //     }
//   //
//   //     print("Voting topic created  in vote_create_topic_controller.dart0");
//   //     print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//   //
//   //     // final createTopic = await event.createVotingTopic(isar, topicName, event);
//   //     // final voteOption = await event.addVoteOptions(isar, createTopic, optionNames, event);
//   //     await loadTopics();
//   //     print("Voting topic created  in vote_create_topic_controller.dart1");
//   //     print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//   //     // ref
//   //     //     .read(voteOverviewControllerProvider(event).notifier)
//   //     //     .addTopic(VotingTopic()
//   //     //   ..title = topicName
//   //     //   ..options.addAll(voteOption)
//   //     //   ..event.value = event);
//   //
//   //     print("Voting topic created  in vote_create_topic_controller.dart2");
//   //     print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//   //     if (context.mounted) {
//   //       print("Voting topic created  in vote_create_topic_controller.dart3");
//   //       print("---------------------------------------------------------------------------------------------------------------------------------------------------------------------");
//   //
//   //       context.pop();
//   //     }
//   //   }
//   }
//
//   // @override
//   // void dispose() {
//   //   topicNameController.dispose();
//   //   optionNameController.dispose();
//   //   optionNameController2.dispose();
//   //   for (var controller in additionalControllers) {
//   //     controller.dispose();
//   //   }
//   //   super.dispose();
//   // }
//
//   Future<List<VoteOption>> getOptionsForVotingTopicAndEvent(
//       Event event, VotingTopic votingTopic) async {
//     await event.votingTopics.load();
//
//     if (event.votingTopics.contains(votingTopic)) {
//       await votingTopic.options.load();
//
//       return votingTopic.options.toList();
//     } else {
//       throw Exception(
//           'The given VotingTopic does not belong to the VotingTopics of the Event');
//     }
//   }
// }
