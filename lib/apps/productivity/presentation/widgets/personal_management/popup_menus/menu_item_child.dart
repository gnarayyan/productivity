import 'package:flutter/material.dart';

class MenuItemChild extends StatelessWidget {
  const MenuItemChild({
    super.key,
    required this.icon,
    required this.label,
    this.child,
  });
  final IconData icon;
  final String label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          icon, 
          size: 16,
          color: theme.brightness == Brightness.dark 
              ? Colors.white 
              : Colors.black87,
        ),
        const SizedBox(width: 12),
        Text(
          label, 
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.dark 
                ? Colors.white 
                : Colors.black87,
          ),
        ),
        if (child != null) ...[const Spacer(), child!],
      ],
    );
  }
}
