import 'package:flutter/material.dart';

class VoteProgressIndicator extends StatelessWidget {
  final int totalVotes;
  final int maxVotes;

  const VoteProgressIndicator({
    super.key,
    required this.totalVotes,
    required this.maxVotes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Abgestimmt $totalVotes/$maxVotes'),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: totalVotes / maxVotes,
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ],
    );
  }
}
