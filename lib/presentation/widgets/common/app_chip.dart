import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class AppChip extends StatelessWidget {
  const AppChip({required this.label, super.key});
  final String label;

  Color _priorityColor() {
    switch (label) {
      case 'High':
        return ColorConstants.priorityHigh;
      case 'Medium':
        return ColorConstants.priorityMedium;
      default:
        return ColorConstants.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = _priorityColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
