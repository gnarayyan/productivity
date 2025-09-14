import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/themes/app_theme.dart';

class ManageCategoriesPage extends StatelessWidget {
  const ManageCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manage Categories'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Manage Categories Page\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
