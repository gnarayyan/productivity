import '../models/goal_model.dart';

final List<Goal> sampleGoals = [
  Goal(
    title: 'Learn Dart Basics',
    progress: 1.0,
    startOn: DateTime.now().subtract(Duration(days: 20)),
    deadline: DateTime.now().subtract(Duration(days: 10)),
  ),
  Goal(
    title: 'Complete Flutter Tutorial',
    progress: 0.5,
    startOn: DateTime.now().subtract(Duration(days: 5)),
    deadline: DateTime.now().add(Duration(days: 10)),
  ),
  Goal(
    title: 'Design App UI',
    progress: 0.0,
    startOn: DateTime.now().add(Duration(days: 1)),
    deadline: DateTime.now().add(Duration(days: 15)),
  ),
  Goal(
    title: 'Setup Firebase',
    progress: 0.9,
    startOn: DateTime.now().subtract(Duration(days: 2)),
    deadline: DateTime.now().add(Duration(days: 5)),
  ),
  Goal(
    title: 'Integrate API',
    progress: 1.0,
    startOn: DateTime.now().subtract(Duration(days: 10)),
    deadline: DateTime.now().subtract(Duration(days: 1)),
  ),
  Goal(
    title: 'Write Unit Tests',
    progress: 0.0,
    startOn: DateTime.now().add(Duration(days: 7)),
    deadline: DateTime.now().add(Duration(days: 20)),
  ),
  Goal(
    title: 'Deploy to Play Store',
    progress: 0.6,
    startOn: DateTime.now().subtract(Duration(days: 1)),
    deadline: DateTime.now().add(Duration(days: 9)),
  ),
  Goal(
    title: 'Refactor Codebase',
    progress: 1.0,
    startOn: DateTime.now().subtract(Duration(days: 30)),
    deadline: DateTime.now().subtract(Duration(days: 5)),
  ),
  Goal(
    title: 'Add Dark Mode',
    progress: 0.3,
    startOn: DateTime.now().subtract(Duration(days: 3)),
    deadline: DateTime.now().add(Duration(days: 10)),
    milestones: [
      Goal(
        title: 'Update Theme Config',
        progress: 1.0,
        startOn: DateTime.now().subtract(Duration(days: 4)),
        deadline: DateTime.now().subtract(Duration(days: 2)),
      ),
      Goal(
        title: 'Test on Devices',
        progress: 0.0,
        startOn: DateTime.now().add(Duration(days: 2)),
        deadline: DateTime.now().add(Duration(days: 7)),
      ),
    ],
  ),
  Goal(
    title: 'Publish App Website',
    progress: 0.8,
    startOn: DateTime.now().subtract(Duration(days: 6)),
    deadline: DateTime.now().add(Duration(days: 4)),
    milestones: [
      Goal(
        title: 'Buy Domain',
        progress: 1.0,
        startOn: DateTime.now().subtract(Duration(days: 10)),
        deadline: DateTime.now().subtract(Duration(days: 8)),
      ),
      Goal(
        title: 'Deploy via GitHub Pages',
        progress: 0.6,
        startOn: DateTime.now().subtract(Duration(days: 1)),
        deadline: DateTime.now().add(Duration(days: 2)),
      ),
    ],
  ),
  Goal(
    title: 'Design App Wireframe',
    progress: 0.8,
    startOn: DateTime.now().subtract(Duration(days: 6)),
    deadline: DateTime.now().add(Duration(days: 1)),
  ),
];
