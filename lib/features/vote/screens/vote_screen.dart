import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/create_topic_dialog.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({super.key});

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: const Text('Vote Area'),
      selectedIndex: 0,
      floatingActionButton: CustomFAB(onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return CreateTopicButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Column(
        children: [
          const SizedBox(height: 16),
          CustomWideButton(
            text: 'Wer kommt alles ?',
            onPressed: () {
              context.push('/vote/topic', extra: {'title': 'Wer kommt alles ?'});
            },
          ),
          const SizedBox(height: 8),
          CustomWideButton(
            text: 'Announcement',
            onPressed: () {
              // Define your onPressed action here
            },
          ),
        ],
      ),
    );
  }
}