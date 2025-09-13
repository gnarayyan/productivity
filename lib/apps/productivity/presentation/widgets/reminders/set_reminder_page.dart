import 'package:flutter/material.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({super.key});

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  bool _isReminderEnabled = false;
  bool _isScreenLockReminderEnabled = false;
  String _selectedReminderType = 'Notification';

  final Set<String> _selectedReminders = {};

  final List<String> _reminderOptions = [
    'At due date-time',
    '5 minutes before',
    '10 minutes before',
    '15 minutes before',
    '30 minutes before',
    '1 hour before',
    '1 day before',
    '2 days before',
    'Custom',
  ];

  final List<String> _reminderTypes = [
    'Notification',
    'Email',
    'SMS',
    'Ring',
    'Alarm',
  ];

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
          'Set Reminder',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reminder Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reminder',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _isReminderEnabled ? 'On' : 'Off',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _isReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isReminderEnabled = value;
                    });
                  },
                  activeColor: const Color(0xFF2196F3),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Remind me section
            Text(
              'Remind me',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            // Reminder options checkboxes
            ..._reminderOptions.map(
              (option) => _buildCheckboxOption(
                option,
                _selectedReminders.contains(option),
                (value) {
                  setState(() {
                    if (value == true) {
                      _selectedReminders.add(option);
                      if (option == 'Custom') {
                        _showCustomReminderBottomSheet();
                      }
                    } else {
                      _selectedReminders.remove(option);
                    }
                  });
                },
                theme,
              ),
            ),

            const SizedBox(height: 32),

            // Reminder type section
            Text(
              'Reminder type',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            // Reminder type options
            ..._reminderTypes.map(
              (type) =>
                  _buildRadioOption(type, _selectedReminderType == type, () {
                    setState(() {
                      _selectedReminderType = type;
                    });
                  }, theme),
            ),

            const SizedBox(height: 32),

            // Screen Lock Reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ScreenLock Reminder',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _isScreenLockReminderEnabled ? 'On' : 'Off',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _isScreenLockReminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isScreenLockReminderEnabled = value;
                    });
                  },
                  activeColor: const Color(0xFF2196F3),
                ),
              ],
            ),

            const SizedBox(height: 48),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: isDark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save reminder settings
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(
    String title,
    bool isSelected,
    ValueChanged<bool?> onChanged,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              activeColor: const Color(0xFF2196F3),
              checkColor: Colors.white,
              side: BorderSide(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                width: 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(
    String title,
    bool isSelected,
    VoidCallback onTap,
    ThemeData theme,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: const Color(0xFF2196F3), width: 2)
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2196F3)
                        : (isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2196F3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomReminderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CustomReminderBottomSheet(),
    );
  }
}

class CustomReminderBottomSheet extends StatefulWidget {
  const CustomReminderBottomSheet({super.key});

  @override
  State<CustomReminderBottomSheet> createState() =>
      _CustomReminderBottomSheetState();
}

class _CustomReminderBottomSheetState extends State<CustomReminderBottomSheet> {
  int _selectedNumber = 5;
  String _selectedTimeFrame = 'Minutes';
  String _selectedBeforeAfter = 'Before';
  bool _addToTimerList = false;
  DateTime? _reminderDateTime;

  final List<String> _timeFrames = [
    'Minutes',
    'Hours',
    'Days',
    'Weeks',
    'Months',
    'Years',
  ];

  final List<String> _beforeAfterOptions = ['Before', 'After'];

  @override
  void initState() {
    super.initState();
    _updateReminderDateTime();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Custom Reminder Time',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 24),

            // Before section
            Text(
              'Before:',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            // iOS Multi Picker with three columns
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Number picker
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedNumber = index + 1;
                          _updateReminderDateTime();
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final number = index + 1;
                          final isSelected = number == _selectedNumber;
                          return Center(
                            child: Text(
                              '$number',
                              style: TextStyle(
                                fontSize: isSelected ? 20 : 16,
                                color: isSelected
                                    ? (isDark ? Colors.white : Colors.black)
                                    : (isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade400),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          );
                        },
                        childCount: 99,
                      ),
                    ),
                  ),
                  // Time frame picker
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedTimeFrame = _timeFrames[index];
                          _updateReminderDateTime();
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final timeFrame = _timeFrames[index];
                          final isSelected = timeFrame == _selectedTimeFrame;
                          return Center(
                            child: Text(
                              timeFrame,
                              style: TextStyle(
                                fontSize: isSelected ? 20 : 16,
                                color: isSelected
                                    ? (isDark ? Colors.white : Colors.black)
                                    : (isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade400),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          );
                        },
                        childCount: _timeFrames.length,
                      ),
                    ),
                  ),
                  // Before/After picker
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedBeforeAfter = _beforeAfterOptions[index];
                          _updateReminderDateTime();
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final option = _beforeAfterOptions[index];
                          final isSelected = option == _selectedBeforeAfter;
                          return Center(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: isSelected ? 20 : 16,
                                color: isSelected
                                    ? (isDark ? Colors.white : Colors.black)
                                    : (isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade400),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          );
                        },
                        childCount: _beforeAfterOptions.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Reminder at section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminder at',
                    style: TextStyle(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _reminderDateTime != null
                        ? '${_reminderDateTime!.month.toString().padLeft(2, '0')}/${_reminderDateTime!.day.toString().padLeft(2, '0')}/${_reminderDateTime!.year}, ${_reminderDateTime!.hour.toString().padLeft(2, '0')}:${_reminderDateTime!.minute.toString().padLeft(2, '0')}'
                        : 'May 12, 2024, 09:41',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Warning message if expired
            if (_isReminderExpired())
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE57373)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Color(0xFFD32F2F), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Reminder time is expired',
                        style: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Add to timer list checkbox
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _addToTimerList,
                    onChanged: (value) {
                      setState(() {
                        _addToTimerList = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF2196F3),
                    checkColor: Colors.white,
                    side: BorderSide(
                      color: isDark
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add to timer list',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: isDark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isReminderExpired()
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _isReminderExpired()
                          ? Colors.grey.shade400
                          : const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateReminderDateTime() {
    final baseDate = DateTime(2024, 5, 12, 9, 41); // Example due date

    final int durationValue = _selectedNumber;
    Duration duration;

    switch (_selectedTimeFrame) {
      case 'Minutes':
        duration = Duration(minutes: durationValue);
        break;
      case 'Hours':
        duration = Duration(hours: durationValue);
        break;
      case 'Days':
        duration = Duration(days: durationValue);
        break;
      case 'Weeks':
        duration = Duration(days: durationValue * 7);
        break;
      case 'Months':
        duration = Duration(days: durationValue * 30);
        break;
      case 'Years':
        duration = Duration(days: durationValue * 365);
        break;
      default:
        duration = Duration(minutes: durationValue);
    }

    setState(() {
      if (_selectedBeforeAfter == 'Before') {
        _reminderDateTime = baseDate.subtract(duration);
      } else {
        _reminderDateTime = baseDate.add(duration);
      }
    });
  }

  bool _isReminderExpired() {
    if (_reminderDateTime == null) return false;
    return _reminderDateTime!.isBefore(DateTime.now());
  }
}
