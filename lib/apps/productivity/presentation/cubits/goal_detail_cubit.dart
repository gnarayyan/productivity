import 'package:flutter_bloc/flutter_bloc.dart';

class GoalDetailCubit extends Cubit<bool> {
  GoalDetailCubit() : super(false);

  void toggleViewGoalDetails() => emit(!state);
}
