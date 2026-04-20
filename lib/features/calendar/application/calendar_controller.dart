import 'package:flutter_riverpod/legacy.dart' show StateNotifier, StateNotifierProvider;

class CalendarState {
  const CalendarState({
    required this.focusedDay,
    required this.selectedDay,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}

class CalendarController extends StateNotifier<CalendarState> {
  CalendarController()
      : super(
          CalendarState(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
          ),
        );

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    state = state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay);
  }
}

final calendarControllerProvider =
    StateNotifierProvider<CalendarController, CalendarState>(
  (ref) => CalendarController(),
);
