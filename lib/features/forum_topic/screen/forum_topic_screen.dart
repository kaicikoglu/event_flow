import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/floating_action_button.dart';
import '../services/forum_topic_controller.dart';
import '../services/forum_topic_provider.dart';
import '../widgets/question_list_widget.dart';

class ForumTopicScreen extends ConsumerStatefulWidget {
  final int forumTopicId;

  const ForumTopicScreen({super.key, required this.forumTopicId});

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
    _controller.loadQuestions(widget.forumTopicId);
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: questionsAsyncValue.when(
                data: (questions) => QuestionList(
                  questions: questions,
                  onExpansionChanged: _handleExpansionChanged,
                ),
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
                  context, widget.forumTopicId),
            ),
    );
  }
}
