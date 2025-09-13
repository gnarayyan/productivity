import 'package:flutter/material.dart';

class PersonalTasksPage extends StatefulWidget {
  const PersonalTasksPage({super.key});

  @override
  State<PersonalTasksPage> createState() => _PersonalTasksPageState();
}

class _PersonalTasksPageState extends State<PersonalTasksPage> {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Draft Project Proposal',
      description: 'Complete project proposal for the new client.',
      dueDate: DateTime(2025, 3, 15),
      priority: TaskPriority.high,
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Coordinate Team Meeting',
      description: 'Schedule and send invites for the weekly sync.',
      dueDate: DateTime(2025, 3, 16),
      priority: TaskPriority.medium,
      isCompleted: false,
    ),
    Task(
      id: '3',
      title: 'Analyze Client Feedback',
      description: 'Review and categorize feedback from the latest survey.',
      dueDate: DateTime(2025, 3, 17),
      priority: TaskPriority.low,
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Search tasks',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),

        // Tasks List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return _buildTaskItem(task, theme);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(Task task, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                task.isCompleted = !task.isCompleted;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: task.isCompleted
                    ? const Color(0xFF2196F3)
                    : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted
                      ? const Color(0xFF2196F3)
                      : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),

          const SizedBox(width: 12),

          // Task Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Due: ${_formatDate(task.dueDate)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildPriorityChip(task.priority, theme),
                  ],
                ),
              ],
            ),
          ),

          // Menu Button
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(TaskPriority priority, ThemeData theme) {
    Color chipColor;
    String label;

    switch (priority) {
      case TaskPriority.high:
        chipColor = const Color(0xFFE57373);
        label = 'High Priority';
        break;
      case TaskPriority.medium:
        chipColor = const Color(0xFFFFB74D);
        label = 'Medium Priority';
        break;
      case TaskPriority.low:
        chipColor = const Color(0xFF81C784);
        label = 'Low Priority';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}

// Task Model
class Task {

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.isCompleted,
  });
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  bool isCompleted;
}

enum TaskPriority { high, medium, low }
