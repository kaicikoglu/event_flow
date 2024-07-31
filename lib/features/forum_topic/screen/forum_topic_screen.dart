import 'package:event_flow/data_models/forum/forum_topic_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/floating_action_button.dart';
import '../services/forum_topic_controller.dart';
import '../services/forum_topic_provider.dart';
import '../widgets/question_list_widget.dart';

class ForumTopicScreen extends ConsumerStatefulWidget {
  final ForumTopic forumTopic;
  final BackButton? backButton;

  const ForumTopicScreen(
      {super.key, required this.forumTopic, this.backButton});

  @override
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends ConsumerState<ForumTopicScreen> {
  late ForumTopicController _controller;
  bool _isTileExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = ForumTopicController(ref);
    _controller.loadQuestions(widget.forumTopic.id);
  }

  void _handleExpansionChanged(bool isExpanded) {
    setState(() {
      _isTileExpanded = isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsyncValue = ref.watch(forumTopicQuestionProvider);

    return Scaffold(
      appBar: AppBar(
        leading: widget.backButton,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.forumTopic.title,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: questionsAsyncValue.when(
                data: (questions) {
                  if (questions.isEmpty) {
                    return const Center(
                      child: Text('Keine Fragen vorhanden!'),
                    );
                  }
                  return QuestionList(
                    questions: questions,
                    onExpansionChanged: _handleExpansionChanged,
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isTileExpanded
          ? null
          : CustomFAB(
              onPressed: () => _controller.showAddQuestionModal(
                  context, widget.forumTopic.id, widget.forumTopic.eventId),
            ),
    );
  }
}
