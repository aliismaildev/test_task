import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/core/theme/app_dimens.dart';
import 'package:test_task/core/widgets/svg_icon.dart';

class TrainingWorkoutCard extends StatelessWidget {
  const TrainingWorkoutCard({
    super.key,
    required this.tagLabel,
    required this.tagBackground,
    required this.tagForeground,
    required this.title,
    required this.durationLabel,
    this.tagIconAsset,
    this.tagIcon,
  });

  final String tagLabel;
  final Color tagBackground;
  final Color tagForeground;
  final String title;
  final String durationLabel;
  final String? tagIconAsset;
  final IconData? tagIcon;

  @override
  Widget build(BuildContext context) {
    final leftRailWidth = 7.w;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: leftRailWidth,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(14.r)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: leftRailWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 12.w, 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, right: 8.w),
                    child: const _GripDots(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: tagBackground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (tagIconAsset != null || tagIcon != null) ...[
                                if (tagIconAsset != null)
                                  SvgIcon.asset(
                                    tagIconAsset!,
                                    size: 10.sp,
                                    color: tagForeground,
                                  )
                                else
                                  Icon(
                                    tagIcon,
                                    size: 11.sp,
                                    color: tagForeground,
                                  ),
                                SizedBox(width: 5.w),
                              ],
                              Text(
                                tagLabel,
                                style: TextStyle(
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: tagForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Padding(
                    padding: EdgeInsets.only(top: 34.h),
                    child: Text(
                      durationLabel,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppColors.textPrimary.withValues(alpha: 0.92),
                        height: 1,
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

class _GripDots extends StatelessWidget {
  const _GripDots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10.w,
      height: 18.h,
      child: Wrap(
        spacing: 4.w,
        runSpacing: 4.h,
        children: List.generate(
          6,
          (_) => Container(
            width: 2.6.w,
            height: 2.6.w,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
