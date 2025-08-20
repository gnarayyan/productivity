import 'package:flutter/material.dart';

import '../../../../../../themes/app_theme.dart';

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
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 12),
        Text(label, style: AppTextStyles.bodyMedium),
        if (child != null) ...[const Spacer(), child!],
      ],
    );
  }
}
