import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoteProgressIndicator extends StatelessWidget {
  final int totalVotes;
  final int maxVotes;

  const VoteProgressIndicator({
    required this.totalVotes,
    required this.maxVotes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Abgestimmt $totalVotes/$maxVotes'),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: totalVotes / maxVotes,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ],
    );
  }
}
