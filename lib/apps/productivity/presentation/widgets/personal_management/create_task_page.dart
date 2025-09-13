import 'package:flutter/material.dart';

import '../reminders/make_habit_page.dart';
import '../reminders/set_reminder_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _dueDate;
  String? _selectedGoal;
  Set<String> _selectedReminders = {'15 min before'};

  final List<String> _goals = [
    'Learn to code',
    'Get fit',
    'Read more books',
    'Learn a new language',
    'Build a portfolio',
  ];

  final List<String> _reminderOptions = [
    '15 min before',
    '1 hour before',
    '1 day before',
    'Custom',
  ];

  @override
  void dispose() {
    _taskTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'New Task',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              _buildTextField(
                controller: _taskTitleController,
                hintText: 'Task title',
                theme: theme,
              ),

              const SizedBox(height: 16),

              // Description
              _buildTextField(
                controller: _descriptionController,
                hintText: 'Description',
                maxLines: 3,
                theme: theme,
              ),

              const SizedBox(height: 24),

              // Priority
              _buildSectionLabel('Priority', theme),
              const SizedBox(height: 12),
              _buildPrioritySelector(theme),

              const SizedBox(height: 24),

              // Due Date
              _buildSectionLabel('Due Date', theme),
              const SizedBox(height: 12),
              _buildDateField(theme),

              const SizedBox(height: 24),

              // Goal
              _buildSectionLabel('Goal', theme),
              const SizedBox(height: 12),
              _buildGoalDropdown(theme),

              const SizedBox(height: 24),

              // Reminders
              _buildSectionLabel('Reminders', theme),
              const SizedBox(height: 12),
              _buildRemindersSection(theme),

              const SizedBox(height: 24),
              _buildNewReminderSection(theme),

              const SizedBox(height: 24),

              // Make it a habit
              _buildHabitSection(theme),

              const SizedBox(height: 40),

              // Create Task Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _createTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Create Task',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, ThemeData theme) {
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required ThemeData theme,
    int maxLines = 1,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 12,
        ),
      ),
    );
  }

  Widget _buildPrioritySelector(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: TaskPriority.values.map((priority) {
        final isSelected = _selectedPriority == priority;
        String label;

        switch (priority) {
          case TaskPriority.low:
            label = 'Low';
            break;
          case TaskPriority.medium:
            label = 'Medium';
            break;
          case TaskPriority.high:
            label = 'High';
            break;
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPriority = priority;
                });
              },
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2196F3)
                      : (isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF5F7FA)),
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(color: const Color(0xFF2196F3))
                      : Border.all(
                          color: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade700),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateField(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _selectDueDate,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _dueDate != null
                    ? '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'
                    : 'Select date',
                style: TextStyle(
                  color: _dueDate != null
                      ? (isDark ? Colors.white : Colors.black)
                      : (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                ),
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 20,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalDropdown(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGoal,
          hint: Text(
            'Select goal',
            style: TextStyle(
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
          ),
          isExpanded: true,
          dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          items: _goals.map((String goal) {
            return DropdownMenuItem<String>(value: goal, child: Text(goal));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGoal = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRemindersSection(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _reminderOptions.map((reminder) {
        final isSelected = _selectedReminders.contains(reminder);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedReminders.remove(reminder);
              } else {
                _selectedReminders.add(reminder);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF2196F3)
                  : (isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF5F7FA)),
              borderRadius: BorderRadius.circular(20),
              border: isSelected
                  ? null
                  : Border.all(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                    ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (reminder == 'Custom' && isSelected)
                  const Icon(Icons.add, size: 16, color: Colors.white),
                if (reminder == 'Custom' && isSelected)
                  const SizedBox(width: 4),
                Text(
                  reminder,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark
                              ? Colors.grey.shade300
                              : Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHabitSection(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const MakeHabitPage()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make it a habit',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'Never',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewReminderSection(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SetReminderPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminder',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    'No',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement task creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task created successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}

enum TaskPriority { low, medium, high }
