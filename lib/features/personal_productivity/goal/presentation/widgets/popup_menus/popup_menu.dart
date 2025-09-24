import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../cubits/goal_detail_cubit.dart';
import '../../../../goal_category/presentation/pages/manage_categories_page.dart';
import 'menu_item_child.dart';

class GoalsPopUpMenu extends StatelessWidget {
  const GoalsPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showDetails = context.watch<GoalDetailCubit>().state;

    return PopupMenuButton<String>(
      icon: Icon(
        LucideIcons.moreVertical,
        color: theme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      color: theme.brightness == Brightness.dark
          ? const Color(0xFF1E1E1E)
          : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: // TODO: Use auto_route
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ManageCategoriesPage(),
              fullscreenDialog: true,
            ),
          ),
          child: const MenuItemChild(
            icon: LucideIcons.folder,
            label: 'Manage Categories',
          ),
        ),

        PopupMenuItem(
          // TODO: fix using bloc
          onTap: () {
            // setState(() {
            //   _isSearchMode = !_isSearchMode;
            //   if (!_isSearchMode) {
            //     _searchController.clear();
            //     _searchQuery = '';
            //   }
            // });
          },
          child: const MenuItemChild(icon: LucideIcons.search, label: 'Search'),
        ),

        const PopupMenuItem(
          // onTap: _showSortDialog,
          child: MenuItemChild(icon: LucideIcons.arrowUpDown, label: 'Sort by'),
        ),

        PopupMenuItem(
          onTap: context.read<GoalDetailCubit>().toggleViewGoalDetails,
          child: MenuItemChild(
            icon: showDetails ? LucideIcons.eyeOff : LucideIcons.eye,
            label: 'Show Details',
            child: Switch(
              value: showDetails,
              onChanged: null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: theme.colorScheme.primary,
              inactiveThumbColor: theme.brightness == Brightness.dark
                  ? Colors.grey.shade400
                  : Colors.grey.shade600,
              inactiveTrackColor: theme.brightness == Brightness.dark
                  ? Colors.grey.shade700
                  : Colors.grey.shade300,
            ),
          ),
        ),

        PopupMenuItem(
          onTap: Scaffold.of(context).openDrawer,
          child: const MenuItemChild(
            icon: LucideIcons.sliders,
            label: 'Advance Options',
          ),
        ),
      ],
    );
  }
}
