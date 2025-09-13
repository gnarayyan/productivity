import 'package:flutter/material.dart';

class MakeHabitPage extends StatefulWidget {
  const MakeHabitPage({super.key});

  @override
  State<MakeHabitPage> createState() => _MakeHabitPageState();
}

class _MakeHabitPageState extends State<MakeHabitPage> {
  bool _isRecurrenceEnabled = true;
  String _selectedFrequency = 'Hourly';
  String _selectedRepeatEvery = '1 Hour';
  final Set<String> _selectedDays = {'M', 'W', 'F'};
  String _selectedRepeatEnds = 'Never';
  int _occurrences = 5;
  DateTime? _endDate;

  final List<String> _frequencies = ['Hourly', 'Daily', 'Weekly', 'Monthly'];
  final List<String> _repeatOptions = [
    '1 Hour',
    '2 Hours',
    '3 Hours',
    '6 Hours',
    '12 Hours',
    '1 Day',
    '1 Week',
    '1 Month',
  ];
  final List<String> _dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

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
          'Make it a habit',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recurrence Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recurrence',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Switch(
                  value: _isRecurrenceEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isRecurrenceEnabled = value;
                    });
                  },
                  activeColor: const Color(0xFF2196F3),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Frequency Section
            _buildSectionLabel('FREQUENCY', theme),
            const SizedBox(height: 16),
            _buildFrequencyChips(theme),

            const SizedBox(height: 32),

            // Repeat Every Section
            _buildSectionLabel('REPEAT EVERY', theme),
            const SizedBox(height: 16),
            _buildDropdownField(
              value: _selectedRepeatEvery,
              options: _repeatOptions,
              onChanged: (value) {
                setState(() {
                  _selectedRepeatEvery = value!;
                });
              },
              theme: theme,
            ),

            const SizedBox(height: 32),

            // Repeat On Section
            _buildSectionLabel('REPEAT ON', theme),
            const SizedBox(height: 16),
            _buildDaySelector(theme),

            const SizedBox(height: 32),

            // Repeat Ends On Section
            _buildSectionLabel('REPEAT ENDS ON', theme),
            const SizedBox(height: 16),
            _buildRepeatEndsOptions(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, ThemeData theme) {
    return Text(
      label,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.brightness == Brightness.dark
            ? Colors.grey.shade400
            : Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFrequencyChips(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Wrap(
      spacing: 12,
      children: _frequencies.map((frequency) {
        final isSelected = frequency == _selectedFrequency;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedFrequency = frequency;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF2196F3)
                  : (isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF5F5F5)),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              frequency,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDaySelector(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _dayLabels.map((day) {
        final isSelected = _selectedDays.contains(day);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedDays.remove(day);
              } else {
                _selectedDays.add(day);
              }
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF2196F3)
                  : (isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFF5F5F5)),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : Colors.black),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRepeatEndsOptions(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Never option
        _buildRadioOption(
          'Never',
          _selectedRepeatEnds == 'Never',
          () => setState(() => _selectedRepeatEnds = 'Never'),
          theme,
        ),

        const SizedBox(height: 16),

        // After option
        Row(
          children: [
            _buildRadioOption(
              'After',
              _selectedRepeatEnds == 'After',
              () => setState(() => _selectedRepeatEnds = 'After'),
              theme,
              showRadio: true,
            ),
            const SizedBox(width: 16),
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '$_occurrences',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _occurrences = int.tryParse(value) ?? _occurrences;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'occurrences',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // On option
        Row(
          children: [
            _buildRadioOption(
              'On',
              _selectedRepeatEnds == 'On',
              () => setState(() => _selectedRepeatEnds = 'On'),
              theme,
              showRadio: true,
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => _selectEndDate(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _endDate != null
                          ? '${_endDate!.month.toString().padLeft(2, '0')}/${_endDate!.day.toString().padLeft(2, '0')}/${_endDate!.year}'
                          : 'mm/dd/yyyy',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(
    String title,
    bool isSelected,
    VoidCallback onTap,
    ThemeData theme, {
    bool showRadio = false,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
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
                    : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
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
          if (!showRadio)
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }
}
