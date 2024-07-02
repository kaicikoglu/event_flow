import 'package:flutter/material.dart';

import 'forum_response.dart';

class QuestionWidget extends StatelessWidget {
  final String question;

  // final bool isExpanded;
  // final VoidCallback onTap;
  final List<ForumResponseWidget> responses;

  const QuestionWidget({
    super.key,
    required this.question,
    // required this.isExpanded,
    // required this.onTap,
    required this.responses,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('author'),
      children: responses
          .map((response) => ForumResponseWidget(response: question, author: '',))
          .toList(),
    );
  }
}
