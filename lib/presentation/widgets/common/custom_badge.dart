import 'package:flutter/material.dart';
import 'package:varosa_tech/data/models/badge_model.dart';
import '../../../core/themes/app_theme.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge(this.badge, {super.key});
  final BadgeModel badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badge.color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        badge.label,
        style: AppTextStyles.bodySmall.copyWith(
          color: badge.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
