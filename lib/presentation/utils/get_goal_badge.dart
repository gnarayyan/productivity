import 'package:flutter/material.dart';
import 'package:varosa_tech/themes/app_theme.dart';
import '../../data/models/badge_model.dart';
import '../../data/models/goal_model.dart';
import 'format_relative_date.dart';

/// Returns a [BadgeModel] object containing a user-friendly label and color
/// for a given [Goal], based on its current [GoalStatus].
///
/// - For [GoalStatus.completed]:
///   - Uses `completedOn` to display "6 months ago", etc.
///   - Color: Green shades.
///
/// - For [GoalStatus.upcoming]:
///   - Uses `startOn` to describe time until start (e.g., "Tomorrow").
///   - Color: Orange shades depending on urgency.
///
/// - For [GoalStatus.pending]:
///   - Uses `deadline` to show urgency ("Overdue", "Due today").
///   - Color: Red for overdue, amber for urgency.
BadgeModel getGoalBadge(Goal goal) {
  final now = DateTime.now();
  final status = goal.status;

  switch (status) {
    case GoalStatus.completed:
      if (goal.completedOn != null) {
        // Completed in past → use friendly "time ago" format
        final label = formatRelativeDate(goal.completedOn!);
        return BadgeModel(label: label, color: Colors.green.shade600);
      }
      // Fallback if completedOn is null
      return BadgeModel(label: 'Completed', color: Colors.green);

    case GoalStatus.upcoming:
      final label = formatRelativeDate(goal.startOn);
      Color color;

      // Closer start dates get lighter or warmer colors
      final daysUntilStart = goal.startOn.difference(now).inDays;
      if (daysUntilStart <= 1) {
        color = AppColors.info.withAlpha(85);
      } else if (daysUntilStart <= 7) {
        color = AppColors.info.withAlpha(115);
      } else {
        color = AppColors.info.withAlpha(170);
      }

      return BadgeModel(label: label, color: color);

    case GoalStatus.pending: // TODO: Chnage colors to AppColors.primary,
      final daysLeft = goal.deadline.difference(now).inDays;
      String label;
      Color color;

      if (daysLeft < 0) {
        // Deadline passed
        label = 'Overdue';
        color = Colors.red.shade600;
      } else if (daysLeft == 0) {
        label = 'Due today';
        color = Colors.amber.shade900;
      } else if (daysLeft <= 3) {
        label = '$daysLeft days left';
        color = Colors.amber.shade800;
      } else if (daysLeft <= 7) {
        label = 'This week';
        color = Colors.amber.shade600;
      } else {
        label = 'Due in $daysLeft days';
        color = Colors.amber.shade200;
      }

      return BadgeModel(label: label, color: color);
  }
}
