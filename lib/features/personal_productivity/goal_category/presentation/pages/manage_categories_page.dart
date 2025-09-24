import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ManageCategoriesPage extends StatefulWidget {
  const ManageCategoriesPage({super.key});

  @override
  State<ManageCategoriesPage> createState() => _ManageCategoriesPageState();
}

class _ManageCategoriesPageState extends State<ManageCategoriesPage> {
  // Sample categories data - replace with your actual data source
  List<CategoryItem> categories = [
    CategoryItem(id: '1', name: 'Personal', goalCount: 13),
    CategoryItem(id: '2', name: 'Work', goalCount: 8),
    CategoryItem(id: '3', name: 'Health & Fitness', goalCount: 5),
    CategoryItem(id: '4', name: 'Learning', goalCount: 12),
    CategoryItem(id: '5', name: 'Finance', goalCount: 7),
    CategoryItem(id: '6', name: 'Social', goalCount: 3),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Manage Categories',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Instruction card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withAlpha(26),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(51),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  LucideIcons.info,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Long press and drag to reorder',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Categories list
          Expanded(
            child: categories.isEmpty
                ? _buildEmptyState(context, theme)
                : _buildCategoriesList(context, theme),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCategoryDialog(context),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Add Category'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.folderPlus,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No Categories Yet',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first category to organize your goals',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context, ThemeData theme) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.only(bottom: 80), // Space for FAB
      itemCount: categories.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = categories.removeAt(oldIndex);
          categories.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryItem(context, theme, category, index);
      },
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    ThemeData theme,
    CategoryItem category,
    int index,
  ) {
    return Container(
      key: ValueKey(category.id),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 2,
        shadowColor: theme.colorScheme.shadow.withAlpha(26),
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colorScheme.outline.withAlpha(26)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              LucideIcons.folder,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          title: Text(
            category.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            '${category.goalCount} goal${category.goalCount != 1 ? 's' : ''}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Goal count badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${category.goalCount}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // More options menu
              PopupMenuButton<String>(
                icon: Icon(
                  LucideIcons.moreVertical,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                surfaceTintColor: theme.colorScheme.surface,
                onSelected: (value) =>
                    _handleMenuAction(context, value, category),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.edit,
                          size: 16,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(width: 12),
                        Text('Edit', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'duplicate',
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.copy,
                          size: 16,
                          color: theme.colorScheme.onSurface,
                        ),
                        const SizedBox(width: 12),
                        Text('Duplicate', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.trash2,
                          size: 16,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Delete',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(
    BuildContext context,
    String action,
    CategoryItem category,
  ) {
    switch (action) {
      case 'edit':
        _showEditCategoryDialog(context, category);
        break;
      case 'duplicate':
        _duplicateCategory(category);
        break;
      case 'delete':
        _showDeleteConfirmation(context, category);
        break;
    }
  }

  void _showAddCategoryDialog(BuildContext context) {
    _showCategoryDialog(
      context,
      title: 'Create New Category',
      initialValue: '',
      onSave: (name) {
        if (name.trim().isNotEmpty) {
          setState(() {
            categories.add(
              CategoryItem(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: name.trim(),
                goalCount: 0,
              ),
            );
          });
        }
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, CategoryItem category) {
    _showCategoryDialog(
      context,
      title: 'Edit Category',
      initialValue: category.name,
      onSave: (name) {
        if (name.trim().isNotEmpty) {
          setState(() {
            final index = categories.indexWhere((c) => c.id == category.id);
            if (index != -1) {
              categories[index] = category.copyWith(name: name.trim());
            }
          });
        }
      },
    );
  }

  void _showCategoryDialog(
    BuildContext context, {
    required String title,
    required String initialValue,
    required Function(String) onSave,
  }) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: theme.colorScheme.surfaceTint,
        title: Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category Name',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller,
                maxLength: 50,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter category name',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category name';
                  }
                  if (value.trim().length < 2) {
                    return 'Category name must be at least 2 characters';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                onSave(controller.text);
                Navigator.of(context).pop();
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _duplicateCategory(CategoryItem category) {
    setState(() {
      categories.add(
        CategoryItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: '${category.name} (Copy)',
          goalCount: 0, // New category starts with 0 goals
        ),
      );
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category "${category.name}" duplicated'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              categories.removeLast();
            });
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, CategoryItem category) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: theme.colorScheme.surfaceTint,
        title: Text(
          'Delete Category',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: RichText(
          text: TextSpan(
            style: theme.textTheme.bodyMedium,
            children: [
              const TextSpan(text: 'Are you sure you want to delete '),
              TextSpan(
                text: '"${category.name}"',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const TextSpan(text: '?'),
              if (category.goalCount > 0) ...[
                const TextSpan(text: '\n\nThis category contains '),
                TextSpan(
                  text:
                      '${category.goalCount} goal${category.goalCount != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.error,
                  ),
                ),
                const TextSpan(text: ' that will be moved to "Uncategorized".'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          FilledButton(
            onPressed: () {
              _deleteCategory(category);
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(CategoryItem category) {
    setState(() {
      categories.removeWhere((c) => c.id == category.id);
    });

    // Show success message with undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Category "${category.name}" deleted'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              categories.add(category);
            });
          },
        ),
      ),
    );
  }
}

// Data model for category items
class CategoryItem {
  final String id;
  final String name;
  final int goalCount;

  CategoryItem({required this.id, required this.name, required this.goalCount});

  CategoryItem copyWith({String? id, String? name, int? goalCount}) {
    return CategoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      goalCount: goalCount ?? this.goalCount,
    );
  }
}
