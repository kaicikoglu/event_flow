import 'package:event_flow/data_models/voting_topic_data_model.dart';
import 'package:event_flow/features/vote/widgets/add_voting_option_button.dart';
import 'package:event_flow/features/vote/widgets/checkbox_wide_button.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../services/voting_controller.dart';
import '../widgets/vote_progress_indicator.dart';
import '../widgets/add_voting_option_button.dart';


class VoteTopicScreen extends ConsumerWidget {
  final Event event;
  final String title;


  const VoteTopicScreen({
    Key? key,
    required this.event,
    required this.title,
  }): super(key: key);

  @override
  BaseScreen build(BuildContext context, WidgetRef ref)  {
    final voteController = ref.read(voteTopicsControllerProvider(event).notifier);
    VotingTopic topic = voteController.getCurrentTopic(title);
    topic.options.load();
    final Future<List<VoteOption>> options =  voteController.getOptionsForVotingTopicAndEvent(event, topic);
    void addOption(String optionLabel) async {
      await voteController.addOption(optionLabel, topic);
    }
    return BaseScreen(
      backButton: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(title),
      selectedIndex: 0,
      floatingActionButton: CustomFAB(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddVotingOption(onOptionCreated: addOption);
            },
          );
        },
      ),
        child: FutureBuilder<List<VoteOption>>(
          future: options,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Zeigen Sie einen Ladeindikator an, während die Daten geladen werden
            } else if (snapshot.hasError) {
              return Text('Fehler: ${snapshot.error}'); // Zeigen Sie eine Fehlermeldung an, wenn ein Fehler auftritt
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CheckboxWideButton(
                    label: snapshot.data![index].label,
                    count: snapshot.data![index].count,
                    isSelected: snapshot.data![index].isSelected,
                    onTap: () {
                      // todo hier kommt der code rein der die auswahl speichert, es muss wahrscheinlich option, votingTopic und event übergeben werden
                    },
                  );
                },
              );
            }
          },
        )
    );
  }
}
