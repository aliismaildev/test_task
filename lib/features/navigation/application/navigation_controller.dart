import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:test_task/core/constants/app_assets.dart';

class NavigationItem {
  const NavigationItem({
    required this.label,
    required this.assetPath,
  });

  final String label;
  final String assetPath;
}

final navigationItemsProvider = Provider<List<NavigationItem>>((ref) {
  return const [
    NavigationItem(label: 'Nutrition', assetPath: AppAssets.nutrition),
    NavigationItem(label: 'Plan', assetPath: AppAssets.calendar),
    NavigationItem(label: 'Mood', assetPath: AppAssets.mood),
    NavigationItem(label: 'Profile', assetPath: AppAssets.profile),
  ];
});

class NavigationController extends StateNotifier<int> {
  NavigationController() : super(0);

  void setTab(int index) => state = index;
}

final navigationControllerProvider =
    StateNotifierProvider<NavigationController, int>(
  (ref) => NavigationController(),
);
