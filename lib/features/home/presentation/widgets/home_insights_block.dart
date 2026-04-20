import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/core/constants/app_assets.dart';
import 'package:test_task/core/theme/app_colors.dart';

const _calorieProgressGradient = LinearGradient(
  colors: [
    AppColors.nutritionWeekBlue,
    AppColors.nutritionWeekTeal,
    AppColors.nutritionWeekGreen,
  ],
);

const _hydrationCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppColors.hydrationGradientStart, AppColors.hydrationGradientEnd],
);

class HomeInsightsBlock extends StatelessWidget {
  const HomeInsightsBlock({
    super.key,
    required this.caloriesCurrent,
    required this.caloriesGoal,
    required this.weightKg,
    required this.weightDeltaKg,
    required this.hydrationPercent,
    required this.hydrationLoggedMl,
    required this.onLogHydration,
  });

  final int caloriesCurrent;
  final int caloriesGoal;
  final double weightKg;
  final double weightDeltaKg;
  final int hydrationPercent;
  final int hydrationLoggedMl;
  final VoidCallback onLogHydration;

  @override
  Widget build(BuildContext context) {
    final remaining = (caloriesGoal - caloriesCurrent).clamp(0, caloriesGoal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Insights',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CaloriesCard(
                current: caloriesCurrent,
                remaining: remaining,
                goal: caloriesGoal,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _WeightCard(
                kg: weightKg,
                deltaKg: weightDeltaKg,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        _HydrationCard(
          percent: hydrationPercent,
          loggedMl: hydrationLoggedMl,
          onLogTap: onLogHydration,
        ),
      ],
    );
  }
}

class _CaloriesCard extends StatelessWidget {
  const _CaloriesCard({
    required this.current,
    required this.remaining,
    required this.goal,
  });

  final int current;
  final int remaining;
  final int goal;

  @override
  Widget build(BuildContext context) {
    final progress = goal == 0 ? 0.0 : (current / goal).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$current',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: 6.w),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Text(
                  'Calories',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            '$remaining Remaining',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              height: 6.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: AppColors.surfaceSoft),
                  FractionallySizedBox(
                    widthFactor: progress,
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: _calorieProgressGradient,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style:
                    TextStyle(fontSize: 10.sp, color: AppColors.textSecondary),
              ),
              Text(
                '$goal',
                style:
                    TextStyle(fontSize: 10.sp, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard({
    required this.kg,
    required this.deltaKg,
  });

  final double kg;
  final double deltaKg;

  @override
  Widget build(BuildContext context) {
    final positive = deltaKg >= 0;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.weightStatusIcon,
                width: 15.sp,
                height: 15.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                '${kg.toStringAsFixed(0)} kg',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                positive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14.sp,
                color: AppColors.accentGreen,
              ),
              SizedBox(width: 2.w),
              Text(
                '${positive ? '+' : ''}${deltaKg.toStringAsFixed(1)}kg',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Weight',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationCard extends StatelessWidget {
  const _HydrationCard({
    required this.percent,
    required this.loggedMl,
    required this.onLogTap,
  });

  final int percent;
  final int loggedMl;
  final VoidCallback onLogTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _hydrationCardGradient,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$percent%',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.insightBlue,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        'Hydration',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: onLogTap,
                        child: Text(
                          'Log Now',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _HydrationGauge(loggedMl: loggedMl),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.hydrationFooterBackground,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(14.r)),
            ),
            alignment: Alignment.center,
            child: Text(
              '$loggedMl ml added to water log',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.hydrationFooterText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationGauge extends StatelessWidget {
  const _HydrationGauge({required this.loggedMl});

  final int loggedMl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 196.w,
      height: 112.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '2L',
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 68.h),
                Text(
                  '0 L',
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          SizedBox(
            width: 14.w,
            height: 88.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      10,
                      (i) {
                        final majorTick = i == 0 || i == 5 || i == 9;
                        return Container(
                          width: majorTick ? 12.w : 4.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: majorTick
                                ? AppColors.insightBlue
                                : AppColors.hydrationTickMuted,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.3.h,
                      color: AppColors.hydrationGuideLine,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${loggedMl}ml',
                        style: TextStyle(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
