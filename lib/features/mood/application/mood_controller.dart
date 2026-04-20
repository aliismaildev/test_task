import 'package:flutter_riverpod/legacy.dart';
import 'package:test_task/features/mood/domain/mood_type.dart';

class MoodController extends StateNotifier<MoodType> {
  MoodController() : super(MoodType.calm);

  void setMood(MoodType mood) {
    state = mood;
  }
}

final moodControllerProvider = StateNotifierProvider<MoodController, MoodType>(
  (ref) => MoodController(),
);
