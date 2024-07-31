import 'package:event_flow/features/forum_topic/widgets/question_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../../data_models/forum/forum_topic_question_data_model.dart';

class QuestionList extends StatefulWidget {
  final List<ForumTopicQuestion> questions;
  final Function(bool) onExpansionChanged;

  const QuestionList({
    super.key,
    required this.questions,
    required this.onExpansionChanged,
  });

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  final ScrollController _scrollController = ScrollController();
  int _expandedIndex = -1;

  void _handleTileExpansion(bool isExpanded, int index) {
    setState(() {
      _expandedIndex = isExpanded ? index : -1;
      widget.onExpansionChanged(isExpanded);
    });
  }

  @override
  void didUpdateWidget(covariant QuestionList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.questions.length != oldWidget.questions.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        final question = widget.questions[index];
        return QuestionTile(
          question: question,
          isExpanded: _expandedIndex == index,
          onExpansionChanged: (isExpanded) =>
              _handleTileExpansion(isExpanded, index),
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(), // Add a divider between each item
    );
  }
}
