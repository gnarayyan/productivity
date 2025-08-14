import 'package:flutter/material.dart';
import 'package:varosa_tech/apps/productivity/data/datasource/sample_data_source.dart';
import 'package:varosa_tech/apps/productivity/data/models/goal_model.dart';
import 'package:varosa_tech/apps/productivity/presentation/widgets/personal_management/goals_widgets/goal_section.dart';
import 'package:varosa_tech/themes/app_theme.dart';

class GoalsListView extends StatelessWidget {
  const GoalsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pending Section
          GoalSection(
            title: 'Pending',
            color: AppColors.warning,
            goals: sampleGoals.pending,
          ),

          const SizedBox(height: 24),

          // Upcoming Section
          GoalSection(
            title: 'Upcoming',
            color: AppColors.info,
            goals: sampleGoals.upcoming,
          ),

          const SizedBox(height: 24),

          // Completed Section
          GoalSection(
            title: 'Completed',
            color: AppColors.success,
            goals: sampleGoals.completed,
          ),
        ],
      ),
    );
  }
}
