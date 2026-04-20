import 'package:flutter_riverpod/legacy.dart';
import 'package:test_task/features/home/domain/workout_type.dart';

class WorkoutController extends StateNotifier<WorkoutType> {
  WorkoutController() : super(WorkoutType.upperBody);

  void setWorkout(WorkoutType workout) {
    state = workout;
  }
}

final workoutControllerProvider =
    StateNotifierProvider<WorkoutController, WorkoutType>(
  (ref) => WorkoutController(),
);
