import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';
import '../widgets/create_topic_dialog.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backButton: BackButton(
        onPressed: () {
          context.pop();
        },
      ),
      title: const Text('Forum'),
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
            text: 'Teilnehmerliste bearbeiten',
            onPressed: () {
              context.push('/forum/topic');
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