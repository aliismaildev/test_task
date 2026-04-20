import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon.asset(
    this.assetPath, {
    super.key,
    required this.color,
    this.size,
    this.fit = BoxFit.contain,
  });

  final String assetPath;
  final Color color;
  final double? size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final dimension = size ?? 24.sp;
    return SvgPicture.asset(
      assetPath,
      width: dimension,
      height: dimension,
      fit: fit,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
