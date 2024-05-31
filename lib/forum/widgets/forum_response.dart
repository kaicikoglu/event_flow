import 'package:flutter/material.dart';

class ForumResponse {
  final String author;
  final String response;

  ForumResponse({
    required this.author,
    required this.response,
  });
}

class ForumResponseWidget extends StatelessWidget {
  final ForumResponse response;

  const ForumResponseWidget({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${response.author}: ${response.response}'),
    );
  }
}