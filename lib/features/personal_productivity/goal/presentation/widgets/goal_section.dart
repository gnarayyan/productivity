import 'package:flutter/material.dart';

import '../../../../../data/models/goal_model.dart';
import 'goal_item.dart';

class GoalSection extends StatelessWidget {
  const GoalSection({
    super.key,
    // required this.title,
    required this.color,
    required this.goals,
  });
  // final String title;
  final Color color;
  // final List<Widget> children;
  final List<Goal> goals;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        //     Container(
        //       width: 4,
        //       height: 20,
        //       decoration: BoxDecoration(
        //         color: color,
        //         borderRadius: BorderRadius.circular(2),
        //       ),
        //     ),
        //     const SizedBox(width: 12),
        //     Text(
        //       title,
        //       style: theme.textTheme.titleLarge?.copyWith(
        //         color: theme.textTheme.titleLarge?.color,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     const SizedBox(width: 8),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        //       decoration: BoxDecoration(
        //         color: color.withAlpha((0.1 * 255).toInt()),
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       child: Text(
        //         '${goals.length}',
        //         style: theme.textTheme.bodySmall?.copyWith(
        //           color: color,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(height: 16),
        ...goals.map(
          (goal) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GoalItem(goal),
          ),
        ),
      ],
    );
  }
}
