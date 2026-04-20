import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:test_task/core/constants/app_assets.dart';
import 'package:test_task/core/theme/app_colors.dart';

enum MoodType {
  calm('Calm', '😊',
      [AppColors.accentPeach, AppColors.accentPink, AppColors.accentBlue]),
  content('Content', '😆',
      [AppColors.accentPeach, AppColors.accentPink, AppColors.accentMint]),
  peaceful('Peaceful', '😌',
      [AppColors.accentPeach, AppColors.accentMint, AppColors.accentBlue]),
  happy('Happy', '🙂',
      [AppColors.accentPeach, AppColors.accentPink, AppColors.accentMint]);

  const MoodType(this.label, this.emoji, this.gradientColors);

  final String label;
  final String emoji;
  final List<Color> gradientColors;
  String get avatarAsset => switch (this) {
        MoodType.calm => AppAssets.moodAvatarCalm,
        MoodType.content => AppAssets.moodAvatarContent,
        MoodType.peaceful => AppAssets.moodAvatarPeaceful,
        MoodType.happy => AppAssets.moodAvatarHappy,
      };
  double get knobAngleRad => switch (this) {
        MoodType.calm => _clockHourToAngle(2),
        MoodType.content => _clockHourToAngle(4.5),
        MoodType.peaceful => _clockHourToAngle(7.5),
        MoodType.happy => _clockHourToAngle(10.5),
      };
}

double _clockHourToAngle(double hour) {
  return -math.pi / 2 + (hour / 12.0) * 2 * math.pi;
}
