import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalCalendarPage extends StatefulWidget {
  const PersonalCalendarPage({super.key});

  @override
  State<PersonalCalendarPage> createState() => _PersonalCalendarPageState();
}

class _PersonalCalendarPageState extends State<PersonalCalendarPage>
    with TickerProviderStateMixin {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isExpanded = true;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  // Sample task events data
  final Map<DateTime, List<TaskEvent>> _events = {
    DateTime.now().subtract(const Duration(days: 2)): [
      TaskEvent('Morning Routine', '10:00 AM', Colors.blue),
      TaskEvent('Project Meeting', '11:00 AM', Colors.green),
    ],
    DateTime.now(): [
      TaskEvent('Morning Routine', '10:00 AM', Colors.blue),
      TaskEvent('Project Meeting', '11:00 AM', Colors.green),
      TaskEvent('Lunch Break', '12:00 PM', Colors.orange),
      TaskEvent('Client Call', '1:00 PM', Colors.red),
    ],
    DateTime.now().add(const Duration(days: 1)): [
      TaskEvent('Team Standup', '9:00 AM', Colors.purple),
    ],
    DateTime.now().add(const Duration(days: 3)): [
      TaskEvent('Code Review', '2:00 PM', Colors.teal),
      TaskEvent('Documentation', '4:00 PM', Colors.indigo),
    ],
  };

  late final ValueNotifier<List<TaskEvent>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedEvents.value = [
      TaskEvent('Morning Routine', '10:00 AM', Colors.blue),
      TaskEvent('Project Meeting', '11:00 AM', Colors.green),
      TaskEvent('Lunch Break', '12:00 PM', Colors.orange),
      TaskEvent('Client Call', '1:00 PM', Colors.red),
    ];

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
    _expandController.forward();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    _expandController.dispose();
    super.dispose();
  }

  List<TaskEvent> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _toggleCalendarView() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _calendarFormat = CalendarFormat.month;
        _expandController.forward();
      } else {
        _calendarFormat = CalendarFormat.week;
        _expandController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F1419)
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF0F1419)
            : const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            // Open drawer or navigation
          },
        ),
        title: Text(
          'Calendar',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isExpanded ? LucideIcons.minimize2 : LucideIcons.maximize2,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: _toggleCalendarView,
            tooltip: _isExpanded ? 'Show week view' : 'Show month view',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: isDark ? Colors.white : Colors.black,
            onPressed: () {
              // Additional menu actions
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar Header
          // _buildCalendarHeader(isDark),

          // Calendar Widget
          AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A2332) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar<TaskEvent>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: TextStyle(
                      color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                    ),
                    holidayTextStyle: TextStyle(
                      color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    todayDecoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2196F3).withAlpha(77)
                          : const Color(0xFF2196F3).withAlpha(51),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    defaultTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Color(0xFFFF9800),
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 3,
                    markerSize: 6,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    titleTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    weekendStyle: TextStyle(
                      color: isDark ? Colors.red.shade300 : Colors.red.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // Today's Tasks Progress
          _buildTodaysProgress(isDark),

          const SizedBox(height: 16),

          // Tasks List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tasks List
          Expanded(
            child: ValueListenableBuilder<List<TaskEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, events, _) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _buildTaskItem(event, isDark, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new task/event
          _showAddTaskDialog(context, isDark);
        },
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTodaysProgress(bool isDark) {
    final todayEvents = _getEventsForDay(DateTime.now());
    final totalTasks = todayEvents.length;
    const completedTasks = 3; // Mock completed tasks

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2332) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "Today's tasks",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            '$completedTasks/$totalTasks',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            height: 6,
            child: LinearProgressIndicator(
              value: totalTasks > 0 ? completedTasks / totalTasks : 0,
              backgroundColor: isDark
                  ? const Color(0xFF2A3441)
                  : const Color(0xFFE8E8E8),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF2196F3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(TaskEvent event, bool isDark, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2332) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child:
                index ==
                    0 // Mock: first task is completed
                ? Icon(
                    Icons.check,
                    size: 16,
                    color: isDark ? Colors.white : Colors.black,
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                    decoration: index == 0 ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.time,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   width: 4,
          //   height: 32,
          //   decoration: BoxDecoration(
          //     color: event.color,
          //     borderRadius: BorderRadius.circular(2),
          //   ),
          // ),
        ],
      ),
    );
  }

  // String _getMonthName(int month) {
  //   const months = [
  //     'January',
  //     'February',
  //     'March',
  //     'April',
  //     'May',
  //     'June',
  //     'July',
  //     'August',
  //     'September',
  //     'October',
  //     'November',
  //     'December',
  //   ];
  //   return months[month - 1];
  // }

  void _showAddTaskDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1A2332) : Colors.white,
        title: Text(
          'Add New Task',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Task Title',
                labelStyle: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Time',
                labelStyle: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                border: const OutlineInputBorder(),
              ),
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add task logic here
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class TaskEvent {

  TaskEvent(this.title, this.time, this.color);
  final String title;
  final String time;
  final Color color;

  @override
  String toString() => title;
}
