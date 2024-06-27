import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/vote_notifier.dart';
import '../../../widgets/base_screen.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/create_topic_dialog.dart';

class VoteScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voteNotifier = ref.watch(voteNotifierProvider);

    return BaseScreen(
      selectedIndex: 1,
      title: const Text('Voting-Area'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateTopicDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      child: voteNotifier.when(
        data: (votes) {
          return ListView.builder(
            itemCount: votes.length,
            itemBuilder: (context, index) {
              return CustomWideButton(
                text: votes[index].name,
                onPressed: () {
                  ref.read(voteNotifierProvider.notifier).removeVote(votes[index].id);
                },
              );
            },
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}