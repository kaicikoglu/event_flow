import 'package:event_flow/features/vote/widgets/create_voting_topic.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../services/voting_controller.dart';

class VoteScreen extends ConsumerWidget {
  final Event event;

  const VoteScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(voteTopicsControllerProvider(event));
    final voteController = ref.read(voteTopicsControllerProvider(event).notifier);
    voteController.loadTopics();

    return BaseScreen(
      backButton: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
      title: const Text('Voting-Area'),
      selectedIndex: 0,
      floatingActionButton: CustomFAB(onPressed: () {
            context.push('/createVotingTopic',extra:event);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomWideButton(
              text: topics[index].title,
              onPressed: () {
                context.push('/voteTopic', extra: {
                  'event': event,
                  'voting_title': topics[index].title,
                });
              },
            ),
          );
        },
      ),
    );
  }
}
