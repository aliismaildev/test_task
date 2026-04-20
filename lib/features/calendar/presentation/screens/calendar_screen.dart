import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/constants/app_assets.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/core/theme/app_dimens.dart';
import 'package:test_task/features/calendar/presentation/widgets/training_workout_card.dart';

const _mockWeekSections = <_WeekSectionData>[
  _WeekSectionData(
    weekLabel: 'Week 2/8',
    monthLabel: 'December 8 -14',
    totalLabel: 'Total: 60min',
    sectionDivider: AppColors.weekSectionDividerBlue,
    days: [
      _DayEntry(
        weekday: 'Mon',
        date: '8',
        highlight: true,
        workoutCard: TrainingWorkoutCard(
          tagLabel: 'Arms Workout',
          tagBackground: AppColors.workoutTagGreenBackground,
          tagForeground: AppColors.accentGreen,
          tagIconAsset: AppAssets.legWorkout,
          title: 'Arm Blaster',
          durationLabel: '25m - 30m',
        ),
      ),
      _DayEntry(
        weekday: 'Tue',
        date: '9',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Wed',
        date: '10',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Thu',
        date: '11',
        highlight: true,
        workoutCard: TrainingWorkoutCard(
          tagLabel: 'Leg Workout',
          tagBackground: AppColors.workoutTagPurpleBackground,
          tagForeground: AppColors.accentPink,
          tagIconAsset: AppAssets.armsWorkout,
          title: 'Leg Day Blitz',
          durationLabel: '25m - 30m',
        ),
      ),
      _DayEntry(
        weekday: 'Fri',
        date: '12',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Sat',
        date: '13',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Sun',
        date: '14',
        highlight: false,
      ),
    ],
  ),
  _WeekSectionData(
    weekLabel: 'Week 3/8',
    monthLabel: 'December 14-22',
    totalLabel: 'Total: 60min',
    sectionDivider: AppColors.weekSectionDividerTeal,
    days: [
      _DayEntry(
        weekday: 'Mon',
        date: '15',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Tue',
        date: '16',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Wed',
        date: '17',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Thu',
        date: '18',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Fri',
        date: '19',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Sat',
        date: '20',
        highlight: false,
      ),
      _DayEntry(
        weekday: 'Sun',
        date: '21',
        highlight: false,
      ),
    ],
  ),
];

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _expandedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.scaffoldBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.screenHorizontal,
                8.h,
                AppDimens.screenHorizontal,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Training Calendar',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 36.h),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                AppDimens.screenHorizontal,
                16.h,
                AppDimens.screenHorizontal,
                24.h,
              ),
              itemCount: _mockWeekSections.length,
              itemBuilder: (context, index) {
                final section = _mockWeekSections[index];
                final expanded = _expandedSectionIndex == index;
                return _ExpandableWeekSection(
                  data: section,
                  expanded: expanded,
                  onTap: () {
                    if (expanded) return;
                    setState(() => _expandedSectionIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableWeekSection extends StatelessWidget {
  const _ExpandableWeekSection({
    required this.data,
    required this.expanded,
    required this.onTap,
  });

  final _WeekSectionData data;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (data.sectionDivider != null)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              height: 2.h,
              color: data.sectionDivider!,
            ),
          ),
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(bottom: expanded ? 14.h : 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.weekLabel,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        data.monthLabel,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color:
                              AppColors.textSecondary.withValues(alpha: 0.88),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  data.totalLabel,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          _ExpandedWeekDays(data: data)
        else
          const _CollapsedWeekDivider(),
      ],
    );
  }
}

class _CollapsedWeekDivider extends StatelessWidget {
  const _CollapsedWeekDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 1,
          color: AppColors.navUnselected.withValues(alpha: 0.42),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}

class _ExpandedWeekDays extends StatelessWidget {
  const _ExpandedWeekDays({
    super.key,
    required this.data,
  });

  final _WeekSectionData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...data.days.map(
          (d) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.weekday,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: d.highlight
                              ? AppColors.textPrimary
                              : AppColors.mutedDate,
                        ),
                      ),
                      Text(
                        d.date,
                        style: TextStyle(
                          fontSize: 35.sp,
                          height: 1.15,
                          fontWeight: FontWeight.w400,
                          color: d.highlight
                              ? AppColors.textPrimary
                              : AppColors.mutedDate,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: d.workoutCard ?? const _EmptyDayDivider(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h, bottom: 12.h),
          child: Container(
            height: 1,
            color: AppColors.navUnselected.withValues(alpha: 0.42),
          ),
        ),
      ],
    );
  }
}

class _WeekSectionData {
  const _WeekSectionData({
    required this.weekLabel,
    required this.monthLabel,
    required this.totalLabel,
    required this.days,
    this.sectionDivider,
  });

  final String weekLabel;
  final String monthLabel;
  final String totalLabel;
  final List<_DayEntry> days;
  final Color? sectionDivider;
}

class _DayEntry {
  const _DayEntry({
    required this.weekday,
    required this.date,
    required this.highlight,
    this.workoutCard,
  });

  final String weekday;
  final String date;
  final bool highlight;
  final Widget? workoutCard;
}

class _EmptyDayDivider extends StatelessWidget {
  const _EmptyDayDivider();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.h),
        Container(
          height: 1,
          color: AppColors.navUnselected.withValues(alpha: 0.42),
        ),
      ],
    );
  }
}
