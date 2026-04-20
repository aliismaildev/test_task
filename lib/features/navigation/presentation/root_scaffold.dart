import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/theme/app_colors.dart';
import 'package:test_task/core/widgets/svg_icon.dart';
import 'package:test_task/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:test_task/features/home/presentation/screens/home_screen.dart';
import 'package:test_task/features/mood/presentation/screens/mood_screen.dart';
import 'package:test_task/features/navigation/application/navigation_controller.dart';
import 'package:test_task/features/profile/presentation/screens/profile_screen.dart';

class RootScaffold extends ConsumerWidget {
  const RootScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(navigationControllerProvider);
    final navItems = ref.watch(navigationItemsProvider);

    const pages = [
      HomeScreen(),
      CalendarScreen(),
      MoodScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBlack,
      body: IndexedStack(
        index: currentTab,
        children: pages,
      ),
      bottomNavigationBar: _FitnessBottomNav(
        currentIndex: currentTab,
        items: navItems,
        onSelect: (i) =>
            ref.read(navigationControllerProvider.notifier).setTab(i),
      ),
    );
  }
}

class _FitnessBottomNav extends StatelessWidget {
  const _FitnessBottomNav({
    required this.currentIndex,
    required this.items,
    required this.onSelect,
  });

  final int currentIndex;
  final List<NavigationItem> items;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBlack,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62.h,
          child: Row(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final selected = i == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onSelect(i),
                  splashColor: AppColors.navSplash,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon.asset(
                        item.assetPath,
                        color: selected
                            ? AppColors.navSelected
                            : AppColors.navUnselected,
                        size: 24.sp,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: selected
                              ? AppColors.navSelected
                              : AppColors.navUnselected,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: 28.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.navSelected
                              : AppColors.transparent,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
