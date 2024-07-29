import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data_models/event/event_data_model.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/create_voting_topic.dart';
import '../services/vote_overview_provider.dart';

class VoteScreen extends ConsumerWidget {
  final Event event;
  final BackButton? backButton;

  const VoteScreen({super.key, required this.event, this.backButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topics = ref.watch(voteOverviewProvider(event));
    final topicController = ref.read(voteOverviewProvider(event).notifier);
    void addTopic(String topicTitle) async {
      await topicController.addTopic(ref.context, topicTitle);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${event.title}\'s Votes'),
        centerTitle: true,
        leading: backButton,
      ),
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
                      context.push('/votingTopic', extra: topics[index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: CreateVotingTopic(
                  event: event,
                  ref: ref,
                  onTopicCreated: addTopic,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
