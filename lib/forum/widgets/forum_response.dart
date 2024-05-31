import 'package:flutter/material.dart';

class ForumResponseWidget extends StatelessWidget {
  final String author;
  final String response;

  const ForumResponseWidget({
    super.key,
    required this.response,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$author: $response'),
    );
  }
}
