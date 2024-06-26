import 'package:event_flow/features/forum/widgets/create_forum_topic.dart';
import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data_models/event_data_model.dart';
import '../../../data_models/forum_topic_data_model.dart';
import '../../../services/isar_service.dart';
import '../../../widgets/floating_action_button.dart';
import '../../../widgets/wide_button.dart';

class ForumScreen extends StatefulWidget {
  final Event event;

  const ForumScreen({super.key, required this.event});

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<ForumTopic> topics = [];

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  Future<void> loadTopics() async {
    await IsarService().initializeIsar();
    await widget.event.forumTopics.load();
    setState(() {
      topics = widget.event.forumTopics.toList();
    });
  }

  void addTopic(String topicTitle) async {
    final isar = IsarService().getIsar();
    await widget.event.createForumTopic(isar, topicTitle);
    await loadTopics();
  }

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
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return CreateForumTopic(onTopicCreated: addTopic);
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            // Adjust the gap as needed
            child: CustomWideButton(
              text: topics[index].title,
              onPressed: () {
                context.push('/topic/${topics[index].id}');
              },
            ),
          );
        },
      ),
    );
  }
}
