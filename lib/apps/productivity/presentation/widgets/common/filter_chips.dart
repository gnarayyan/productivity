import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(name),
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: isSelected
            ? theme.colorScheme.onPrimary
            : theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onSelect(name);
        }
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary,
      checkmarkColor: theme.colorScheme.onPrimary,
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.outline.withValues(alpha: 0.3),
        width: isSelected ? 1.5 : 1,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: isSelected ? 2 : 0,
      pressElevation: 4,
    );
  }
}
