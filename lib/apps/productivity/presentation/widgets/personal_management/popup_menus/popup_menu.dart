import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../../../themes/app_theme.dart';
import '../../../cubits/goal_detail_cubit.dart';
import '../manage_categories_page.dart';
import 'menu_item_child.dart';

class GoalsPopUpMenu extends StatelessWidget {
  const GoalsPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final showDetails = context.watch<GoalDetailCubit>().state;
    return PopupMenuButton<String>(
      icon: const Icon(LucideIcons.moreVertical),
      color: AppColors.surface,
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
          child: MenuItemChild(
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
          child: MenuItemChild(icon: LucideIcons.search, label: 'Search'),
        ),

        PopupMenuItem(
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
            ),
          ),
        ),

        PopupMenuItem(
          onTap: Scaffold.of(context).openDrawer,
          child: MenuItemChild(
            icon: LucideIcons.sliders,
            label: 'Advance Options',
          ),
        ),
      ],
    );
  }
}
