import 'package:flutter/material.dart';

class CreateTopicButton extends StatelessWidget {
  final VoidCallback onPressed;

  CreateTopicButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thema erstellen'),
      content: const TextField(
        decoration:
        InputDecoration(hintText: "Geben Sie hier Ihr Thema ein"),
        maxLength: 10, // Begrenzt die Eingabe auf 10 Zeichen
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Bestätigen'),
          onPressed: () {
            Navigator.of(context).pop(); // Schließt den Dialog
          },
        ),
      ],
    );
  }
}

