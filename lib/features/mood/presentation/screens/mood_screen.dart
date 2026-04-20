import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/core/theme/app_dimens.dart';
import 'package:test_task/core/widgets/screen_top_glow.dart';
import 'package:test_task/features/mood/application/mood_controller.dart';
import 'package:test_task/features/mood/presentation/widgets/mood_ring.dart';

class MoodScreen extends ConsumerWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mood = ref.watch(moodControllerProvider);
    final notifier = ref.read(moodControllerProvider.notifier);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        const ColoredBox(color: AppColors.scaffoldBlack),
        const ScreenTopGlow(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  'Mood',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.3,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding:  EdgeInsets.only(
                      top: 8.sp,
                      left: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start your day',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        'How are you feeling at the Moment?',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 28.h),
                    ],
                  ),
                ),

                Center(
                  child: MoodRing(
                    mood: mood,
                    onMoodChanged: notifier.setMood,
                  ),
                ),
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    mood.label,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.surfaceSoft,
                          content: Text(
                            'Mood "${mood.label}" saved',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: AppColors.scaffoldBlack,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
