import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../../vote_create_topic/services/vote_create_topic_controller.dart';

class VoteOverviewScreen extends ConsumerWidget {
  final Event event;

  const VoteOverviewScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(createTopicControllerProvider(event));

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
                    text: topics[index].topicTitle,
                    onPressed: () {
                      context.push('/votingTopic',  extra: topics[index]);
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
