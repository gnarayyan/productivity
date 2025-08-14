import 'package:flutter/material.dart';
import '../../../../../themes/app_theme.dart';
import '../personal_management/table.dart';

class GoalListItem extends StatelessWidget {
  final String title;
  final double progress;
  final String badge;
  final Color badgeColor;
  final bool showDetails;
  final int milestonesTotal;
  final int milestonesPending;
  final int milestonesCompleted;
  final int tasksTotal;
  final int tasksPending;
  final int tasksCompleted;

  const GoalListItem({
    super.key,
    required this.title,
    required this.progress,
    required this.badge,
    required this.badgeColor,
    required this.showDetails,
    required this.milestonesTotal,
    required this.milestonesPending,
    required this.milestonesCompleted,
    required this.tasksTotal,
    required this.tasksPending,
    required this.tasksCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha((0.08 * 255).toInt()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
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
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: badgeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.outline.withAlpha(
                      (0.3 * 255).toInt(),
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? AppColors.success : AppColors.primary,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),

            // Details Section (conditional)
            if (showDetails) StatsTable(),
          ],
        ),
      ),
    );
  }
}
