import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/theme/app_colors.dart';

class ScreenTopGlow extends StatelessWidget {
  const ScreenTopGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -120.h,
      left: 0,
      right: 0,
      height: 380.h,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.0, -0.6),
            radius: 1.4,
            colors: [
              AppColors.topGlowCore.withValues(alpha: 0.9),
              AppColors.topGlowCore.withValues(alpha: 0.35),
              AppColors.topGlowCore.withValues(alpha: 0.1),
              AppColors.transparent,
            ],
            stops: const [0.0, 0.3, 0.6, 1.0],
          ),
        ),
      ),
    );
  }
}
