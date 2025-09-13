import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PersonalDashboardPage extends StatefulWidget {
  const PersonalDashboardPage({super.key});

  @override
  State<PersonalDashboardPage> createState() => _PersonalDashboardPageState();
}

class _PersonalDashboardPageState extends State<PersonalDashboardPage>
    with TickerProviderStateMixin {
  String _selectedTimeFrame = 'Hourly';
  late AnimationController _progressAnimationController;
  late AnimationController _chartAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _chartAnimation;

  final List<String> _timeFrames = ['Hourly', 'Weekly', 'Monthly', 'Yearly'];

  final List<double> _weeklyData = [65, 45, 75, 85, 35, 55, 95];
  final List<String> _weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  // Task status data
  final int _completedTasks = 45;
  final int _pendingTasks = 28;
  final int _dueTasks = 12;

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _chartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _chartAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // Start animations
    _progressAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _chartAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _chartAnimationController.dispose();
    super.dispose();
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
          'Dashboard',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goals Progress Circle
            _buildGoalsProgressCard(isDark),

            const SizedBox(height: 30),

            // Tasks Progress Section
            Text(
              'Tasks Progress Report',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // Time Frame Selector
            _buildTimeFrameSelector(isDark),

            const SizedBox(height: 24),

            // Completed Tasks Section
            _buildCompletedTasksCard(isDark),

            const SizedBox(height: 24),

            // Task Status Overview Section
            _buildTaskStatusOverviewCard(isDark),

            const SizedBox(height: 24),

            // Task Completion Rate Card
            _buildTaskCompletionRateCard(isDark),

            const SizedBox(height: 24),

            // Task Categories Chart
            _buildTaskCategoriesCard(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsProgressCard(bool isDark) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
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
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 180,
                      child: CircularProgressIndicator(
                        value: 0.75 * _progressAnimation.value,
                        strokeWidth: 12,
                        backgroundColor: isDark
                            ? const Color(0xFF2A3441)
                            : const Color(0xFFE8E8E8),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF2196F3),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return Text(
                              '${(75 * _progressAnimation.value).toInt()}%',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            );
                          },
                        ),
                        Text(
                          'Goals Done',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeFrameSelector(bool isDark) {
    return Row(
      children: _timeFrames.map((timeFrame) {
        final isSelected = timeFrame == _selectedTimeFrame;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTimeFrame = timeFrame;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2196F3)
                      : (isDark
                            ? const Color(0xFF1A2332)
                            : const Color(0xFFF0F0F0)),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    timeFrame,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark
                                ? Colors.grey.shade400
                                : Colors.grey.shade600),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
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

  Widget _buildCompletedTasksCard(bool isDark) {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks Completed',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(
                        animation: _chartAnimation,
                        builder: (context, child) {
                          return Text(
                            '${(120 * _chartAnimation.value).toInt()}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            'Last 7 Days',
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+10%',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Bar Chart
              SizedBox(
                height: 120,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 100,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 &&
                                value.toInt() < _weekDays.length) {
                              return Text(
                                _weekDays[value.toInt()],
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const Text('');
                          },
                          reservedSize: 32,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: _weeklyData.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value * _chartAnimation.value,
                            color: const Color(0xFF2196F3),
                            width: 20,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskStatusOverviewCard(bool isDark) {
    final total = _completedTasks + _pendingTasks + _dueTasks;

    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Status Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              // Status Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatusCard(
                      'Completed',
                      _completedTasks,
                      const Color(0xFF4CAF50),
                      Icons.check_circle_rounded,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      'Pending',
                      _pendingTasks,
                      const Color(0xFFFF9800),
                      Icons.schedule_rounded,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusCard(
                      'Due',
                      _dueTasks,
                      const Color(0xFFFF5252),
                      Icons.warning_rounded,
                      isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Horizontal Bar Chart showing distribution
              Column(
                children: [
                  _buildHorizontalProgressBar(
                    'Completed',
                    _completedTasks,
                    total,
                    const Color(0xFF4CAF50),
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHorizontalProgressBar(
                    'Pending',
                    _pendingTasks,
                    total,
                    const Color(0xFFFF9800),
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHorizontalProgressBar(
                    'Due',
                    _dueTasks,
                    total,
                    const Color(0xFFFF5252),
                    isDark,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(
    String label,
    int count,
    Color color,
    IconData icon,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A3441) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(51), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _chartAnimation,
            builder: (context, child) {
              return Text(
                '${(count * _chartAnimation.value).toInt()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              );
            },
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProgressBar(
    String label,
    int value,
    int total,
    Color color,
    bool isDark,
  ) {
    final percentage = total > 0 ? value / total : 0.0;

    return Row(
      children: [
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A3441) : const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage * _chartAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),

        // const SizedBox(width: 12),
        // SizedBox(
        //   width: 20,
        //   child: AnimatedBuilder(
        //     animation: _chartAnimation,
        //     builder: (context, child) {
        //       return Text(
        //         '${(value * _chartAnimation.value).toInt()}',
        //         style: TextStyle(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w600,
        //           color: color,
        //         ),
        //         textAlign: TextAlign.end,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildTaskCompletionRateCard(bool isDark) {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Completion Rate',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AnimatedBuilder(
                        animation: _chartAnimation,
                        builder: (context, child) {
                          return Text(
                            '${(85 * _chartAnimation.value).toInt()}%',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            'Last 30 Days',
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '-5%',
                            style: TextStyle(
                              color: Color(0xFFFF5252),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Line Chart
              SizedBox(
                height: 100,
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const titles = ['W1', 'W2', 'W3', 'W4'];
                            if (value.toInt() >= 0 &&
                                value.toInt() < titles.length) {
                              return Text(
                                titles[value.toInt()],
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const Text('');
                          },
                          reservedSize: 32,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 3,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 75 * _chartAnimation.value),
                          FlSpot(1, 82 * _chartAnimation.value),
                          FlSpot(2, 68 * _chartAnimation.value),
                          FlSpot(3, 85 * _chartAnimation.value),
                        ],
                        isCurved: true,
                        color: const Color(0xFF2196F3),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF2196F3).withAlpha(26),
                        ),
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: const Color(0xFF2196F3),
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTaskCategoriesCard(bool isDark) {
    return AnimatedBuilder(
      animation: _chartAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              // Pie Chart
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 35 * _chartAnimation.value,
                        color: const Color(0xFF2196F3),
                        radius: 50,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 25 * _chartAnimation.value,
                        color: const Color(0xFFE91E63),
                        radius: 50,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 20 * _chartAnimation.value,
                        color: const Color(0xFF9C27B0),
                        radius: 50,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        value: 20 * _chartAnimation.value,
                        color: const Color(0xFF673AB7),
                        radius: 50,
                        showTitle: false,
                      ),
                    ],
                    sectionsSpace: 4,
                    centerSpaceRadius: 60,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Legend
              Column(
                children: [
                  Row(
                    children: [
                      _buildLegendItem('Work', const Color(0xFF2196F3), isDark),
                      const SizedBox(width: 32),
                      _buildLegendItem(
                        'Personal',
                        const Color(0xFFE91E63),
                        isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildLegendItem(
                        'Errands',
                        const Color(0xFF9C27B0),
                        isDark,
                      ),
                      const SizedBox(width: 32),
                      _buildLegendItem(
                        'Learning',
                        const Color(0xFF673AB7),
                        isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
