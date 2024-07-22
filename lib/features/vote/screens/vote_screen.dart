import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data_models/vote/voting_topic_data_model.dart';
import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../services/vote_overview_provider.dart';

class VoteScreen extends ConsumerWidget {
  final Event event;

  const VoteScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(voteOverviewControllerProvider(event));
    for (var topic in topics) {
      print("Topic title: "+topic.title);
      print("Topic id: "+topic.id.toString());
    }


    return Scaffold(
      body: topics.isEmpty
          ? const Center(
              child: Text(
                'No topics yet. Be the first to create a topic!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomWideButton(
                    text: topics[index].title,
                    onPressed: () {
                      print("Topic title: "+topics[index].title);
                      print("Topic id: "+topics[index].id.toString());
                      context.push('/votingTopic', extra: topics[index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: CustomFAB(onPressed: () {
        context.push('/createVotingTopic', extra: event);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

