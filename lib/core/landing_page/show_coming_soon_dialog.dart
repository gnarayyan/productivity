import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/themes/app_theme.dart';

void showComingSoonDialog(BuildContext context, String appName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(LucideIcons.clock, color: AppColors.primary, size: 24),
            const SizedBox(width: 12),
            Text(
              'Coming Soon',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          '$appName is currently under development and will be available soon.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
