import 'package:flutter/material.dart';

import '../widgets/enter_argument_widget.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            EnterArgumentWidget(
              argument: 'Event Name:',
              hintText: 'Enter event name',
            ),
            SizedBox(height: 16),
            EnterArgumentWidget(
              argument: 'Description:',
              hintText: 'Enter event description',
            ),
            SizedBox(height: 16),
            EnterArgumentWidget(
              argument: 'Date:',
              hintText: 'Enter event date',
            ),
            SizedBox(height: 16),
            EnterArgumentWidget(
              argument: 'Time:',
              hintText: 'Enter event time',
            ),
            SizedBox(height: 16),
            EnterArgumentWidget(
              argument: 'Location:',
              hintText: 'Enter event location',
            ),
          ],
        ),
      ),
    );
  }
}