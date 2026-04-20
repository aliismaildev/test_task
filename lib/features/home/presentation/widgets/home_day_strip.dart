import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/theme/app_colors.dart';

const _weekdayLabels = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];

DateTime startOfWeekMonday(DateTime d) {
  final day = DateTime(d.year, d.month, d.day);
  return day.subtract(Duration(days: day.weekday - DateTime.monday));
}

class HomeDayStrip extends StatelessWidget {
  const HomeDayStrip({
    super.key,
    required this.weekStart,
    required this.selected,
    required this.onSelect,
  });

  final DateTime weekStart;
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (_, __) => SizedBox(width: 6.w),
        itemBuilder: (context, index) {
          final day = weekStart.add(Duration(days: index));
          final isSelected = _isSameDay(day, selected);
          final label = _weekdayLabels[index];

          return SizedBox(
            width: 46.w,
            height: 96.h,
            child: GestureDetector(
              onTap: () => onSelect(day),
              behavior: HitTestBehavior.opaque,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      width: 38.w,
                      height: 38.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.transparent
                            : AppColors.surfaceSoft,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.daySelectedGreen
                              : AppColors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      height: 6.h,
                      child: Center(
                        child: isSelected
                            ? Container(
                                width: 4.w,
                                height: 4.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.daySelectedGreen,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

bool _isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
