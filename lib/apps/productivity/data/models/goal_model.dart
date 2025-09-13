extension GoalListExtensions on List<Goal> {
  List<Goal> get total => this;

  List<Goal> get completed =>
      where((goal) => goal.status == GoalStatus.completed).toList();

  List<Goal> get pending =>
      where((goal) => goal.status == GoalStatus.pending).toList();

  List<Goal> get upcoming =>
      where((goal) => goal.status == GoalStatus.upcoming).toList();
}

enum GoalStatus { pending, upcoming, completed }

class Goal {

  Goal( {
    required this.title,
    required this.progress,
    required this.startOn,
    required this.deadline,
    this.completedOn,
    this.milestones = const [],
  });
  final String title;
  final double progress;
  final DateTime startOn;
  final DateTime deadline;
  final DateTime? completedOn;

  final List<Goal> milestones;

  GoalStatus get status {
    if (progress >= 1.0) {
      return GoalStatus.completed;
    } else if (startOn.isAfter(DateTime.now())) {
      return GoalStatus.upcoming;
    } else {
      return GoalStatus.pending;
    }
  }
}
