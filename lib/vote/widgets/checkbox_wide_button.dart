import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxWideButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const CheckboxWideButton({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.green : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                SizedBox(width: 8),
                Text(label, style: TextStyle(fontSize: 18)),
              ],
            ),
            Text(count.toString(), style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}