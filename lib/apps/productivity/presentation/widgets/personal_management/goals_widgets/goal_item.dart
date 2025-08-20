import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/apps/productivity/data/models/badge_model.dart';
import 'package:varosa_tech/apps/productivity/data/models/goal_model.dart';

import '../../../cubits/goal_detail_cubit.dart';
import '../../../utils/get_goal_badge.dart';
import '../../common/custom_badge.dart';
import '../table.dart';

// TODO: Convert it to expansion tile
class GoalItem extends StatelessWidget {
  final Goal goal;

  const GoalItem(this.goal, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final BadgeModel badge = getGoalBadge(goal);

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: theme.brightness == Brightness.dark
            ? []
            : [
                BoxShadow(
                  color: theme.shadowColor.withAlpha((0.08 * 255).toInt()),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
        border: theme.brightness == Brightness.dark
            ? Border.all(color: Colors.grey.shade800, width: 1)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Due date text
            Text(
              _getDueDateText(goal.title),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.brightness == Brightness.dark
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
            ),

            // const SizedBox(height: 12),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${(goal.progress * 100).toInt()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: 0.7,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomBadge(badge),

                //   ],
                // ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: theme.colorScheme.outline.withAlpha(
                      (0.3 * 255).toInt(),
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(badge.color),
                    minHeight: 6,
                  ),
                ),
              ],
            ),

            // Details Section (conditional)
            // TODO: Replace it with similar goalview for nested goals(milestones)
            BlocBuilder<GoalDetailCubit, bool>(
              builder: (context, isVisible) {
                return isVisible ? StatsTable() : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getDueDateText(String goalTitle) {
    // Static due dates based on goal titles for demo purposes
    switch (goalTitle.toLowerCase()) {
      case 'finish project proposal':
      case 'launch new product':
        return 'Due in 2 days';
      case 'plan team offsite':
      case 'finalize marketing strategy':
        return 'Due in 5 days';
      case 'learn a new skill':
      case 'hire new team members':
        return 'Due in 1 week';
      case 'secure funding':
        return 'Due in 2 weeks';
      default:
        return 'Due in 3 days';
    }
  }
}
