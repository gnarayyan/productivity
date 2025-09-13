import 'package:flutter/material.dart';

class CreateGoalPage extends StatefulWidget {
  const CreateGoalPage({super.key});

  @override
  State<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  final _formKey = GlobalKey<FormState>();
  final _goalNameController = TextEditingController();
  final _motivationController = TextEditingController();
  final _rewardController = TextEditingController();

  DateTime? _startDate;
  DateTime? _deadline;
  TimeOfDay? _notificationTime;
  String? _selectedCategory;

  final List<String> _categories = [
    'Personal',
    'Work',
    'Health',
    'Learning',
    'Finance',
    'Fitness',
  ];

  @override
  void dispose() {
    _goalNameController.dispose();
    _motivationController.dispose();
    _rewardController.dispose();
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
          'Add Goal',
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
              // Goal Name
              _buildSectionLabel('Goal Name', theme),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _goalNameController,
                hintText: 'e.g., Learn to code',
                theme: theme,
              ),

              const SizedBox(height: 24),

              // Start Date and Deadline
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Start Date', theme),
                        const SizedBox(height: 8),
                        _buildDateField(
                          value: _startDate,
                          hintText: 'Select Date',
                          onTap: _selectStartDate,
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionLabel('Deadline', theme),
                        const SizedBox(height: 8),
                        _buildDateField(
                          value: _deadline,
                          hintText: 'Select Date',
                          onTap: _selectDeadline,
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Task Notification Time
              _buildSectionLabel('Task Notification Time', theme),
              const SizedBox(height: 8),
              _buildTimeField(theme),

              const SizedBox(height: 24),

              // Category
              _buildSectionLabel('Category', theme),
              const SizedBox(height: 8),
              _buildCategoryDropdown(theme),

              const SizedBox(height: 24),

              // Motivation
              _buildSectionLabel('Motivation', theme),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _motivationController,
                hintText: 'What drives you to achieve this?',
                maxLines: 4,
                theme: theme,
              ),

              const SizedBox(height: 24),

              // Reward
              _buildSectionLabel('Reward', theme),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _rewardController,
                hintText: 'How will you celebrate your success?',
                maxLines: 4,
                theme: theme,
              ),

              const SizedBox(height: 40),

              // Add Goal Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _createGoal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Add Goal',
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
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: theme.brightness == Brightness.dark
            ? Colors.grey.shade300
            : Colors.grey.shade700,
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
        fillColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
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

  Widget _buildDateField({
    required DateTime? value,
    required String hintText,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value != null
                    ? '${value.day}/${value.month}/${value.year}'
                    : hintText,
                style: TextStyle(
                  color: value != null
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

  Widget _buildTimeField(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _selectNotificationTime,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _notificationTime != null
                    ? _notificationTime!.format(context)
                    : 'Select Time',
                style: TextStyle(
                  color: _notificationTime != null
                      ? (isDark ? Colors.white : Colors.black)
                      : (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                ),
              ),
            ),
            Icon(
              Icons.access_time,
              size: 20,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          hint: Text(
            'Select a category',
            style: TextStyle(
              color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
            ),
          ),
          isExpanded: true,
          dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          items: _categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _notificationTime) {
      setState(() {
        _notificationTime = picked;
      });
    }
  }

  void _createGoal() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement goal creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Goal created successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
