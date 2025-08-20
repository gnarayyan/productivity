import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:varosa_tech/apps/productivity/presentation/cubits/goal_detail_cubit.dart';
import 'package:varosa_tech/apps/productivity/presentation/widgets/personal_management/goals_widgets/goals_list_view.dart';
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
          return PersonalGoalsView();
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
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Personal',
    'Work',
    'Health',
    'Learning',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filter/Search Section
        SizedBox(
          height: 60,
          // color: AppColors.primary,
          child: _isSearchMode
              ? Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search goals...',
                      prefixIcon: IconButton(
                        icon: const Icon(LucideIcons.arrowLeft),
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
                              icon: const Icon(LucideIcons.x),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
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
                        itemCount: _categories.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final String category = _categories[index];

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

                    GoalsPopUpMenu(),
                  ],
                ),
        ),

        GoalsListView(),
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
}
