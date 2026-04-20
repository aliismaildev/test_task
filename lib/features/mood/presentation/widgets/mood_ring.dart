import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/features/mood/domain/mood_type.dart';

class MoodRing extends StatelessWidget {
  const MoodRing({
    super.key,
    required this.mood,
    required this.onMoodChanged,
  });

  final MoodType mood;
  final ValueChanged<MoodType> onMoodChanged;

  @override
  Widget build(BuildContext context) {
    final outer = 248.w;
    final stroke = 20.w;
    final inner = 110.w;
    final boxSide = outer;

    return SizedBox(
      width: boxSide,
      height: boxSide,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (d) =>
            _pickMood(d.localPosition, boxSide, mood, onMoodChanged),
        onTapUp: (d) =>
            _pickMood(d.localPosition, boxSide, mood, onMoodChanged),
        child: CustomPaint(
          painter: _MoodRingPainter(
            knobAngle: mood.knobAngleRad,
            strokeWidth: stroke,
          ),
          child: Center(
            child: Container(
              width: inner,
              height: inner,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.scaffoldBlack.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.r),
                child: SvgPicture.asset(
                  mood.avatarAsset,
                  width: inner,
                  height: inner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickMood(
    Offset local,
    double boxSide,
    MoodType current,
    ValueChanged<MoodType> onChanged,
  ) {
    final cx = boxSide / 2;
    final cy = boxSide / 2;
    final dx = local.dx - cx;
    final dy = local.dy - cy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len < 24) return;

    final ux = dx / len;
    final uy = dy / len;

    MoodType best = MoodType.calm;
    var bestDot = -2.0;
    for (final m in MoodType.values) {
      final mx = math.cos(m.knobAngleRad);
      final my = math.sin(m.knobAngleRad);
      final dot = ux * mx + uy * my;
      if (dot > bestDot) {
        bestDot = dot;
        best = m;
      }
    }
    if (best != current) onChanged(best);
  }
}

class _MoodRingPainter extends CustomPainter {
  const _MoodRingPainter({
    required this.knobAngle,
    required this.strokeWidth,
  });

  final double knobAngle;
  final double strokeWidth;

  static const List<Color> _sweepColors = [
    AppColors.moodRingTeal,
    AppColors.moodRingTeal,
    AppColors.moodRingLavender,
    AppColors.moodRingLavender,
    AppColors.moodRingPink,
    AppColors.moodRingPink,
    AppColors.moodRingOrange,
    AppColors.moodRingOrange,
    AppColors.moodRingTeal,
  ];

  static const List<double> _sweepStops = [
    0.0,
    0.18,
    0.25,
    0.43,
    0.50,
    0.68,
    0.75,
    0.93,
    1.0,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final ringPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: -math.pi / 2,
        endAngle: 1.5 * math.pi,
        colors: _sweepColors,
        stops: _sweepStops,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawCircle(center, radius, ringPaint);

    const tickCount = 24;
    for (var k = 0; k < tickCount; k++) {
      final a = -math.pi / 2 + k * 2 * math.pi / tickCount;
      final c = math.cos(a);
      final s = math.sin(a);
      final rIn = radius - strokeWidth * 0.52;
      final rOut = radius + strokeWidth * 0.52;
      canvas.drawLine(
        Offset(center.dx + rIn * c, center.dy + rIn * s),
        Offset(center.dx + rOut * c, center.dy + rOut * s),
        Paint()
          ..color = AppColors.navSelected.withValues(alpha: 0.26)
          ..strokeWidth = 0.85
          ..strokeCap = StrokeCap.round,
      );
    }

    final knobCenter = Offset(
      center.dx + radius * math.cos(knobAngle),
      center.dy + radius * math.sin(knobAngle),
    );
    final knobR = strokeWidth * 0.82;
    final knobPath = Path()
      ..addOval(Rect.fromCircle(center: knobCenter, radius: knobR));
    canvas.drawShadow(
      knobPath,
      AppColors.scaffoldBlack.withValues(alpha: 0.35),
      4,
      false,
    );
    canvas.drawPath(knobPath, Paint()..color = AppColors.navSelected);
    canvas.drawPath(
      knobPath,
      Paint()
        ..color = AppColors.scaffoldBlack.withValues(alpha: 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant _MoodRingPainter oldDelegate) {
    return oldDelegate.knobAngle != knobAngle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
