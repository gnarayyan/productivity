import 'package:flutter/material.dart';
import '../../../../../themes/app_theme.dart';

class GoalChip extends StatelessWidget {
  final String name;
  final void Function(String) onSelect;
  final bool isSelected;

  const GoalChip({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(name),
      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onSelect(name);
        }
      },

      backgroundColor: AppColors.textHint.withAlpha(75),
      selectedColor: AppColors.primary,

      checkmarkColor: AppColors.onPrimary,
      side: BorderSide(
        color: isSelected
            ? AppColors.textHint.withAlpha(75)
            : AppColors.textHint.withAlpha(50),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
