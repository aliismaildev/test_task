import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/constants/app_assets.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/core/theme/app_dimens.dart';
import 'package:test_task/core/widgets/svg_icon.dart';
import 'package:test_task/core/utils/date_formatter.dart';
import 'package:test_task/features/home/application/home_ui_controller.dart';
import 'package:test_task/features/home/application/workout_controller.dart';
import 'package:test_task/features/home/presentation/widgets/home_day_strip.dart';
import 'package:test_task/features/home/presentation/widgets/home_insights_block.dart';
import 'package:test_task/features/home/presentation/widgets/home_workout_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final home = ref.watch(homeUiProvider);
    final workout = ref.watch(workoutControllerProvider);
    final notifier = ref.read(homeUiProvider.notifier);

    final weekStart = startOfWeekMonday(home.selectedDate);
    final now = DateTime.now();

    return ColoredBox(
      color: AppColors.scaffoldBlack,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _HomeTopBar(
                weekPhase: home.weekPhase,
                weeksInMonth: home.weeksInMonth,
                onSelectWeek: notifier.setWeekPhase,
              ),
              SizedBox(height: 16.h),
              Text(
                DateFormatter.homeHeading(home.selectedDate, now),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 18.h),
              HomeDayStrip(
                weekStart: weekStart,
                selected: home.selectedDate,
                onSelect: notifier.selectDay,
              ),
              SizedBox(height: 6.h),
              Center(
                child: GestureDetector(
                  onTap: () => _showHomeCalendarSheet(
                    context: context,
                    initialSelectedDate: home.selectedDate,
                    onSelectDate: notifier.selectDay,
                  ),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    child: Container(
                      width: 50.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.dragHandle,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workouts',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      SvgIcon.asset(
                        AppAssets.weather,
                        size: 18.sp,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '9°',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              HomeWorkoutCard(
                subtitle:
                    '${DateFormatter.monthDayLong(home.selectedDate)} - 25m - 30m',
                title: workout.label,
                onTap: () {},
              ),
              SizedBox(height: 22.h),
              HomeInsightsBlock(
                caloriesCurrent: 550,
                caloriesGoal: 2500,
                weightKg: 75,
                weightDeltaKg: 1.6,
                hydrationPercent: 0,
                hydrationLoggedMl: home.hydrationLoggedMl,
                onLogHydration: notifier.logHydrationSample,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar({
    required this.weekPhase,
    required this.weeksInMonth,
    required this.onSelectWeek,
  });

  final int weekPhase;
  final int weeksInMonth;
  final ValueChanged<int> onSelectWeek;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 40.w, minHeight: 40.w),
          onPressed: () {},
          icon: SvgIcon.asset(
            AppAssets.notifications,
            color: AppColors.textPrimary,
            size: 24.sp,
          ),
        ),
        Expanded(
          child: Center(
            child: PopupMenuButton<int>(
              initialValue: weekPhase,
              onSelected: onSelectWeek,
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              itemBuilder: (context) => List.generate(
                weeksInMonth,
                (index) {
                  final value = index + 1;
                  return PopupMenuItem<int>(
                    value: value,
                    child: Text(
                      'Week $value/$weeksInMonth',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                },
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgIcon.asset(
                      AppAssets.clock,
                      color: AppColors.textPrimary,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Week $weekPhase/$weeksInMonth',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 40.w),
      ],
    );
  }
}

Future<void> _showHomeCalendarSheet({
  required BuildContext context,
  required DateTime initialSelectedDate,
  required ValueChanged<DateTime> onSelectDate,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: false,
    backgroundColor: AppColors.transparent,
    barrierColor: AppColors.modalBarrier,
    builder: (sheetContext) {
      var visibleMonth = DateTime(
        initialSelectedDate.year,
        initialSelectedDate.month,
      );

      return StatefulBuilder(
        builder: (context, setState) {
          final monthDays = _buildMonthGridDays(visibleMonth);
          return SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 16.h),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.calendarSheetHandle,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            visibleMonth = DateTime(
                              visibleMonth.year,
                              visibleMonth.month - 1,
                            );
                          });
                        },
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          size: 22.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            _monthYearLabel(visibleMonth),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            visibleMonth = DateTime(
                              visibleMonth.year,
                              visibleMonth.month + 1,
                            );
                          });
                        },
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 22.sp,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: _calendarWeekLabels
                        .map(
                          (label) => Expanded(
                            child: Center(
                              child: Text(
                                label,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary
                                      .withValues(alpha: 0.9),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 10.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: monthDays.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.35,
                    ),
                    itemBuilder: (context, index) {
                      final day = monthDays[index];
                      if (day == null) return const SizedBox.shrink();

                      final isSelected = _isSameDate(day, initialSelectedDate);
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            onSelectDate(day);
                            Navigator.of(sheetContext).pop();
                          },
                          child: Container(
                            width: 34.w,
                            height: 34.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: AppColors.daySelectedGreen,
                                      width: 1.7,
                                    )
                                  : null,
                            ),
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

const _calendarWeekLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

String _monthYearLabel(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.year}';
}

List<DateTime?> _buildMonthGridDays(DateTime month) {
  final firstDay = DateTime(month.year, month.month, 1);
  final leadingEmpty = firstDay.weekday - DateTime.monday;
  final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
  final cells = <DateTime?>[
    ...List<DateTime?>.filled(leadingEmpty, null),
    ...List.generate(
      daysInMonth,
      (i) => DateTime(month.year, month.month, i + 1),
    ),
  ];

  final trailingEmpty = (7 - (cells.length % 7)) % 7;
  return [...cells, ...List<DateTime?>.filled(trailingEmpty, null)];
}

bool _isSameDate(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
