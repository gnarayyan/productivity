import 'package:flutter/material.dart';
import 'package:varosa_tech/data/datasource/sample_data_source.dart';
import 'package:varosa_tech/data/models/goal_model.dart';
import 'package:varosa_tech/features/personal_productivity/goal/presentation/widgets/goal_section.dart';

class GoalsListView extends StatelessWidget {

  const GoalsListView({super.key, required this.selectedTab});
  final String selectedTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? const Color(0xFF121212)
              : const Color(0xFFF5F5F5),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (selectedTab == 'Pending') ...[
              // Pending Section
              GoalSection(
                // title: 'Pending',
                color: const Color(0xFFFF9800), // Orange for pending
                goals: sampleGoals.pending,
              ),
            ] else if (selectedTab == 'Upcoming') ...[
              // Upcoming Section
              GoalSection(
                // title: 'Upcoming',
                color: const Color(0xFF2196F3), // Blue for upcoming
                goals: sampleGoals.upcoming,
              ),
            ] else if (selectedTab == 'Completed') ...[
              // Completed Section
              GoalSection(
                // title: 'Completed',
                color: const Color(0xFF4CAF50), // Green for completed
                goals: sampleGoals.completed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
