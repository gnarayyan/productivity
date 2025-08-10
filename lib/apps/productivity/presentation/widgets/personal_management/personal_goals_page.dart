import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../../themes/app_theme.dart';
import '../common/filter_chips.dart';
import '../common/goal_list_item.dart';

class PersonalGoalsPage extends StatefulWidget {
  const PersonalGoalsPage({super.key});

  @override
  State<PersonalGoalsPage> createState() => _PersonalGoalsPageState();
}

class _PersonalGoalsPageState extends State<PersonalGoalsPage> {
  bool _isSearchMode = false;
  bool _showDetails = false;
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Goals',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(LucideIcons.moreVertical),
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              switch (value) {
                case 'manage_categories':
                  _showManageCategoriesPage();
                  break;
                case 'search':
                  setState(() {
                    _isSearchMode = !_isSearchMode;
                    if (!_isSearchMode) {
                      _searchController.clear();
                      _searchQuery = '';
                    }
                  });
                  break;
                case 'sort':
                  _showSortDialog();
                  break;
                case 'show_details':
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'manage_categories',
                child: Row(
                  children: [
                    const Icon(LucideIcons.folder, size: 16),
                    const SizedBox(width: 12),
                    Text('Manage Categories', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'search',
                child: Row(
                  children: [
                    const Icon(LucideIcons.search, size: 16),
                    const SizedBox(width: 12),
                    Text('Search', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'sort',
                child: Row(
                  children: [
                    const Icon(LucideIcons.arrowUpDown, size: 16),
                    const SizedBox(width: 12),
                    Text('Sort by', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'show_details',
                child: Row(
                  children: [
                    Icon(
                      _showDetails ? LucideIcons.eyeOff : LucideIcons.eye,
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Text('Show Details', style: AppTextStyles.bodyMedium),
                    const Spacer(),
                    Switch(
                      value: _showDetails,
                      onChanged: null,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter/Search Section
          Container(
            color: AppColors.primary,
            child: Column(
              children: [
                if (_isSearchMode)
                  Container(
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
                else
                  FilterChips(
                    categories: _categories,
                    selectedCategory: _selectedFilter,
                    onCategoryChanged: (category) {
                      setState(() {
                        _selectedFilter = category;
                      });
                    },
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Goals List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Pending Section
                _buildSection('Pending', AppColors.warning, [
                  GoalListItem(
                    title: 'Learn Flutter Development',
                    progress: 0.65,
                    badge: 'overdue',
                    badgeColor: AppColors.error,
                    showDetails: _showDetails,
                    milestonesTotal: 5,
                    milestonesPending: 2,
                    milestonesCompleted: 3,
                    tasksTotal: 15,
                    tasksPending: 8,
                    tasksCompleted: 7,
                  ),
                  GoalListItem(
                    title: 'Complete Project Portfolio',
                    progress: 0.45,
                    badge: '7 days left',
                    badgeColor: AppColors.primary,
                    showDetails: _showDetails,
                    milestonesTotal: 3,
                    milestonesPending: 2,
                    milestonesCompleted: 1,
                    tasksTotal: 12,
                    tasksPending: 7,
                    tasksCompleted: 5,
                  ),
                ]),

                const SizedBox(height: 24),

                // Upcoming Section
                _buildSection('Upcoming', AppColors.info, [
                  GoalListItem(
                    title: 'Master Data Structures',
                    progress: 0.0,
                    badge: 'next month',
                    badgeColor: AppColors.secondary,
                    showDetails: _showDetails,
                    milestonesTotal: 4,
                    milestonesPending: 4,
                    milestonesCompleted: 0,
                    tasksTotal: 20,
                    tasksPending: 20,
                    tasksCompleted: 0,
                  ),
                ]),

                const SizedBox(height: 24),

                // Completed Section
                _buildSection('Completed', AppColors.success, [
                  GoalListItem(
                    title: 'Learn Basic Programming',
                    progress: 1.0,
                    badge: '6 months ago',
                    badgeColor: AppColors.success,
                    showDetails: _showDetails,
                    milestonesTotal: 3,
                    milestonesPending: 0,
                    milestonesCompleted: 3,
                    tasksTotal: 10,
                    tasksPending: 0,
                    tasksCompleted: 10,
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSection(String title, Color color, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${children.length}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children.map(
          (child) =>
              Padding(padding: const EdgeInsets.only(bottom: 12), child: child),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: FloatingActionButton.extended(
        key: const ValueKey('fab'),
        onPressed: () {
          _showCreateGoalPage();
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Add Goal'),
      ),
    );
  }

  void _showManageCategoriesPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ManageCategoriesPage(),
        fullscreenDialog: true,
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Sort by',
          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption('Due date'),
            _buildRadioOption('Alphabetical A-Z'),
            _buildRadioOption('Alphabetical Z-A'),
            _buildRadioOption('Creation time'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String text) {
    return RadioListTile<String>(
      title: Text(text, style: AppTextStyles.bodyMedium),
      value: text,
      groupValue: 'Due date', // Default selected
      onChanged: (value) {},
      activeColor: AppColors.primary,
    );
  }

  void _showCreateGoalPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateGoalPage(),
        fullscreenDialog: true,
      ),
    );
  }
}

// Placeholder pages
class ManageCategoriesPage extends StatelessWidget {
  const ManageCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Manage Categories'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Manage Categories Page\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class CreateGoalPage extends StatelessWidget {
  const CreateGoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Goal'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Save',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Create Goal Page\nComing Soon!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
