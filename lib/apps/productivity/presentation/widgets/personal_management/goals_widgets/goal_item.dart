import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varosa_tech/apps/productivity/data/models/badge_model.dart';
import 'package:varosa_tech/apps/productivity/data/models/goal_model.dart';

import '../../../../../../themes/app_theme.dart';
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
    final BadgeModel badge = getGoalBadge(goal);
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
                    goal.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
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
                    CustomBadge(badge),
                    Text(
                      '${(goal.progress * 100).toInt()}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: AppColors.outline.withAlpha(
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
}
