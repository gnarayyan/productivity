import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/presentation/cubits/goal_detail_cubit.dart';
import 'package:varosa_tech/presentation/widgets/personal_management/goals_widgets/goals_list_view.dart';
import '../common/filter_chips.dart';
import 'popup_menus/popup_menu.dart';

class PersonalGoalsPage extends StatelessWidget {
  const PersonalGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoalDetailCubit(),
      child: Builder(
        builder: (context) {
          return const PersonalGoalsView();
        },
      ),
    );
  }
}

class PersonalGoalsView extends StatefulWidget {
  const PersonalGoalsView({super.key});

  @override
  State<PersonalGoalsView> createState() => _PersonalGoalsViewState();
}

class _PersonalGoalsViewState extends State<PersonalGoalsView> {
  bool _isSearchMode = false;
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedTab = 'Pending'; // Add selected tab state
  final TextEditingController _searchController = TextEditingController();

  final List<String> _lightModeCategories = [
    'All',
    'Today',
    'This Week',
    'This Month',
  ];

  final List<String> _darkModeCategories = [
    'All',
    'Personal',
    'Work',
    'Health',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Filter/Search Section
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF121212)
                : const Color(0xFFF5F5F5),
          ),
          child: _isSearchMode
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search goals...',
                      hintStyle: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(
                          LucideIcons.arrowLeft,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSearchMode = false;
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                LucideIcons.x,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: theme.brightness == Brightness.dark
                            ? _darkModeCategories.length
                            : _lightModeCategories.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final categories = theme.brightness == Brightness.dark
                              ? _darkModeCategories
                              : _lightModeCategories;
                          final String category = categories[index];

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GoalChip(
                              name: category,
                              isSelected: category == _selectedFilter,
                              onSelect: (category) {
                                setState(() {
                                  _selectedFilter = category;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    const GoalsPopUpMenu(),
                  ],
                ),
        ),

        // Tabs Section (Pending, Upcoming, Completed)
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF121212)
                : const Color(0xFFF5F5F5),
            border: Border(
              bottom: BorderSide(
                color: theme.brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildTabItem('Pending', _selectedTab == 'Pending', theme),
              _buildTabItem('Upcoming', _selectedTab == 'Upcoming', theme),
              _buildTabItem('Completed', _selectedTab == 'Completed', theme),
            ],
          ),
        ),

        GoalsListView(selectedTab: _selectedTab),
      ],
    );
  }

  // void _showSortDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       backgroundColor: AppColors.surface,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       title: Text(
  //         'Sort by',
  //         style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w600),
  //       ),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           _buildRadioOption('Due date'),
  //           _buildRadioOption('Alphabetical A-Z'),
  //           _buildRadioOption('Alphabetical Z-A'),
  //           _buildRadioOption('Creation time'),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text(
  //             'Cancel',
  //             style: AppTextStyles.titleMedium.copyWith(
  //               color: AppColors.textSecondary,
  //             ),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColors.primary,
  //             foregroundColor: AppColors.onPrimary,
  //           ),
  //           child: const Text('Apply'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildRadioOption(String text) {
  //   return RadioListTile<String>(
  //     title: Text(text, style: AppTextStyles.bodyMedium),
  //     value: text,
  //     groupValue: 'Due date', // Default selected
  //     onChanged: (value) {},
  //     activeColor: AppColors.primary,
  //   );
  // }

  Widget _buildTabItem(String title, bool isSelected, ThemeData theme) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = title;
          });
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? (theme.brightness == Brightness.dark
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? (theme.brightness == Brightness.dark
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary)
                    : (theme.brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
