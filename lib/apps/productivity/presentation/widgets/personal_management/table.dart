import 'package:flutter/material.dart';

// Assume these classes and variables are defined elsewhere in your project
class AppColorsx {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.purple;
  static const Color textSecondary = Colors.grey;
  static const Color info = Colors.blue;
  static const Color warning = Colors.orange;
  static const Color success = Colors.green;
}

class AppTextStylesx {
  static const TextStyle bodySmall = TextStyle(fontSize: 12);
}

class LucideIconsx {
  static const IconData flag = Icons.flag;
  static const IconData checkSquare = Icons.check_box;
}

// Dummy data for example
const int milestonesTotal = 15;
const int milestonesPending = 5;
const int milestonesCompleted = 10;
const int tasksTotal = 25;
const int tasksPending = 10;
const int tasksCompleted = 15;

// This is the custom Stat Chip widget
Widget _buildStatChip(String label, int value, Color color) {
  return Text(
    '$value',
    textAlign: TextAlign.center,
    style: AppTextStylesx.bodySmall.copyWith(
      color: color,
      fontWeight: FontWeight.w600,
    ),
  );
}

// The new widget containing the table
class StatsTable extends StatelessWidget {
  const StatsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,

      columnWidths: const {
        0: IntrinsicColumnWidth(), // For the icon and label column
        1: FlexColumnWidth(), // For the stats chips
        2: FlexColumnWidth(), // For the stats chips
        3: FlexColumnWidth(), // For the stats chips
      },
      children: [
        // Header
        const TableRow(
          children: [
            SizedBox(),
            Cell('   Total'),
            Cell(' Pending'),
            Cell('    Done'),
          ],
        ),
        // TableRow for Milestones
        TableRow(
          children: [
            const Cell('Milestones'),
            _buildStatChip('Total', milestonesTotal, AppColorsx.info),

            _buildStatChip('Pending', milestonesPending, AppColorsx.warning),

            _buildStatChip('Done', milestonesCompleted, AppColorsx.success),
          ],
        ),

        // TableRow for Tasks
        TableRow(
          children: [
            const Cell('Tasks'),

            _buildStatChip('Total', tasksTotal, AppColorsx.info),

            _buildStatChip('Pending', tasksPending, AppColorsx.warning),

            _buildStatChip('Done', tasksCompleted, AppColorsx.success),
          ],
        ),
      ],
    );
  }
}

class Cell extends StatelessWidget {
  const Cell(this.value, {super.key, this.color = AppColorsx.textSecondary});

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      child: Text(
        value,
        style: AppTextStylesx.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
