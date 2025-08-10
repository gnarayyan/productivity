import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../themes/app_theme.dart';

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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                    backgroundColor: AppColors.outline.withAlpha((0.3 * 255).toInt()),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? AppColors.success : AppColors.primary,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
            
            // Details Section (conditional)
            if (showDetails) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Milestones Stats
                    Row(
                      children: [
                        Icon(
                          LucideIcons.flag,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Milestones:',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        _buildStatChip('Total', milestonesTotal, AppColors.info),
                        const SizedBox(width: 4),
                        _buildStatChip('Pending', milestonesPending, AppColors.warning),
                        const SizedBox(width: 4),
                        _buildStatChip('Done', milestonesCompleted, AppColors.success),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Tasks Stats
                    Row(
                      children: [
                        Icon(
                          LucideIcons.checkSquare,
                          size: 16,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Tasks:',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        _buildStatChip('Total', tasksTotal, AppColors.info),
                        const SizedBox(width: 4),
                        _buildStatChip('Pending', tasksPending, AppColors.warning),
                        const SizedBox(width: 4),
                        _buildStatChip('Done', tasksCompleted, AppColors.success),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: AppTextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
