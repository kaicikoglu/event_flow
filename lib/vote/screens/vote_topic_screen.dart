import 'package:event_flow/widgets/base_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/floating_action_button.dart';
import '../../widgets/wide_button.dart';
import '../widgets/create_topic_dialog.dart';
import '../widgets/checkbox_wide_button.dart';
import '../widgets/vote_progress_indicator.dart';



class VoteTopicScreen extends StatefulWidget {
  final String title;

  const VoteTopicScreen({
    super.key,
    required this.title,
  });

  @override
  _VoteTopicScreenState createState() => _VoteTopicScreenState();
}

class _VoteTopicScreenState extends State<VoteTopicScreen> {
  int totalVotes = 13; // Total number of votes
  int maxVotes = 20; // Maximum possible votes
  int count1 = 7;
  int count2 = 4;
  int count3 = 2;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoteProgressIndicator(
              totalVotes: totalVotes,
              maxVotes: maxVotes,
            ),
            SizedBox(height: 16),
            CheckboxWideButton(
              label: 'Zusagen',
              count: count1,
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                  count1++;
                  totalVotes++;
                });
              },
            ),
            CheckboxWideButton(
              label: 'Absagen',
              count: count2,
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                  count2++;
                  totalVotes++;
                });
              },
            ),
            CheckboxWideButton(
              label: 'Unsicher',
              count: count3,
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                  count3++;
                  totalVotes++;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Create Topic'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}