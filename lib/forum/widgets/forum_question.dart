import 'package:flutter/material.dart';

import 'forum_response.dart';

class QuestionWidget extends StatelessWidget {
  final String author;
  final String question;
  // final bool isExpanded;
  // final VoidCallback onTap;
  final List<ForumResponse> responses;

  const QuestionWidget({
    Key? key,
    required this.author,
    required this.question,
    // required this.isExpanded,
    // required this.onTap,
    required this.responses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('$author: $question'),
      children: responses.map((response) => ForumResponseWidget(response: response)).toList(),
    );
  }
}