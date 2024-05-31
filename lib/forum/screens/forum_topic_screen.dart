import 'package:flutter/material.dart';

import '../widgets/forum_response.dart';
import '../widgets/question_widget.dart';

class ForumTopicScreen extends StatefulWidget {
  final String title;

  const ForumTopicScreen({super.key, required this.title});

  @override
  _ForumTopicScreenState createState() => _ForumTopicScreenState();
}

class _ForumTopicScreenState extends State<ForumTopicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: const [
          SizedBox(height: 16),
          QuestionWidget(
            author: 'Autor 1',
            question:
                'Wie lange kann der Text sein damit es richtig scheiße aussieht?',
            responses: [
              ForumResponseWidget(
                author: 'Antwortender 1',
                response: 'Dies ist die erste Antwort auf die Frage.',
              ),
              ForumResponseWidget(
                author: 'Antwortender 2',
                response: 'Dies ist die zweite Antwort auf die Frage.',
              ),
            ],
          ),
          QuestionWidget(
            author: 'Autor 2',
            question: 'Frage 2',
            responses: [],
          ),
          QuestionWidget(
            author: 'Autor 3',
            question: 'Frage 3',
            responses: [],
          ),
        ],
      ),
    );
  }
}
