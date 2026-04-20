import 'package:flutter_riverpod/legacy.dart';

class HomeUiState {
  const HomeUiState({
    required this.selectedDate,
    this.weekPhase = 1,
    this.weeksInMonth = 4,
    this.hydrationLoggedMl = 0,
  });

  final DateTime selectedDate;
  final int weekPhase;
  final int weeksInMonth;
  final int hydrationLoggedMl;

  HomeUiState copyWith({
    DateTime? selectedDate,
    int? weekPhase,
    int? weeksInMonth,
    int? hydrationLoggedMl,
  }) {
    return HomeUiState(
      selectedDate: selectedDate ?? this.selectedDate,
      weekPhase: weekPhase ?? this.weekPhase,
      weeksInMonth: weeksInMonth ?? this.weeksInMonth,
      hydrationLoggedMl: hydrationLoggedMl ?? this.hydrationLoggedMl,
    );
  }
}

class HomeUiNotifier extends StateNotifier<HomeUiState> {
  HomeUiNotifier()
      : super(
          (() {
            final today = DateTime.now();
            final meta = _monthWeekMeta(today);
            return HomeUiState(
              selectedDate: today,
              weekPhase: meta.weekPhase,
              weeksInMonth: meta.weeksInMonth,
            );
          })(),
        );

  void selectDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    final meta = _monthWeekMeta(normalized);
    state = state.copyWith(
      selectedDate: normalized,
      weekPhase: meta.weekPhase,
      weeksInMonth: meta.weeksInMonth,
    );
  }

  void setWeekPhase(int phase) {
    if (phase < 1 || phase > state.weeksInMonth) return;
    final selected = state.selectedDate;
    final weekdayOffset = selected.weekday - DateTime.monday;
    final firstOfMonth = DateTime(selected.year, selected.month, 1);
    final firstWeekStart = _startOfWeekMonday(firstOfMonth);
    final targetWeekStart = firstWeekStart.add(Duration(days: (phase - 1) * 7));
    final targetDate = targetWeekStart.add(Duration(days: weekdayOffset));

    state = state.copyWith(
      weekPhase: phase,
      weeksInMonth: state.weeksInMonth,
      selectedDate: DateTime(
        targetDate.year,
        targetDate.month,
        targetDate.day,
      ),
    );
  }

  void logHydrationSample() {
    state = state.copyWith(hydrationLoggedMl: 0);
  }
}

_MonthWeekMeta _monthWeekMeta(DateTime date) {
  final normalized = DateTime(date.year, date.month, date.day);
  final firstOfMonth = DateTime(normalized.year, normalized.month, 1);
  final lastOfMonth = DateTime(normalized.year, normalized.month + 1, 0);
  final startOfWeek = _startOfWeekMonday(normalized);
  final firstWeekStart = _startOfWeekMonday(firstOfMonth);
  final lastWeekStart = _startOfWeekMonday(lastOfMonth);
  final dayDelta = startOfWeek.difference(firstWeekStart).inDays;
  final weekPhase = (dayDelta ~/ 7) + 1;
  final totalWeeks = (lastWeekStart.difference(firstWeekStart).inDays ~/ 7) + 1;
  return _MonthWeekMeta(weekPhase: weekPhase, weeksInMonth: totalWeeks);
}

DateTime _startOfWeekMonday(DateTime d) {
  return d.subtract(Duration(days: d.weekday - DateTime.monday));
}

class _MonthWeekMeta {
  const _MonthWeekMeta({
    required this.weekPhase,
    required this.weeksInMonth,
  });

  final int weekPhase;
  final int weeksInMonth;
}

final homeUiProvider = StateNotifierProvider<HomeUiNotifier, HomeUiState>(
  (ref) => HomeUiNotifier(),
);
