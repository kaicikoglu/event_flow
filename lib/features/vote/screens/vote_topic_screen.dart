import 'package:event_flow/data_models/vote/voting_topic_data_model.dart';
import 'package:event_flow/features/vote/widgets/add_voting_option_button.dart';
import 'package:event_flow/features/vote/widgets/checkbox_wide_button.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../services/voting_controller.dart';


class VoteTopicScreen extends ConsumerWidget {
  final Event event;
  final String title;


  const VoteTopicScreen({
    Key? key,
    required this.event,
    required this.title,
  }): super(key: key);

  @override
  Scaffold build(BuildContext context, WidgetRef ref)  {
    final voteController = ref.read(voteTopicsControllerProvider(event).notifier);
    VotingTopic topic = voteController.getCurrentTopic(title);
    topic.options.load();
    final Future<List<VoteOption>> options =  voteController.getOptionsForVotingTopicAndEvent(event, topic);
    void addOption(String optionLabel) async {
      await voteController.addOption(optionLabel, topic);
    }
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(title),
      ),
      body: FutureBuilder<List<VoteOption>>(
        future: options,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator while data is being loaded
          } else if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}')); // Show an error message if an error occurs
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CheckboxWideButton(
                  label: snapshot.data![index].label,
                  count: snapshot.data![index].count,
                  isSelected: snapshot.data![index].isSelected,
                  onTap: () {
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddVotingOption(onOptionCreated: addOption);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}