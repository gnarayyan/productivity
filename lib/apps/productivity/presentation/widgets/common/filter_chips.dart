import 'package:flutter/material.dart';
import '../../../../../themes/app_theme.dart';

class FilterChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const FilterChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isSelected = category == selectedCategory;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(
                  category,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected ? AppColors.onPrimary : AppColors.onPrimary.withAlpha((0.8 * 255).toInt()),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onCategoryChanged(category);
                  }
                },
                backgroundColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                selectedColor: Colors.white.withAlpha((0.2 * 255).toInt()),
                checkmarkColor: AppColors.onPrimary,
                side: BorderSide(
                  color: isSelected 
                      ? Colors.white.withAlpha((0.3 * 255).toInt())
                      : Colors.white.withAlpha((0.2 * 255).toInt()),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
