import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavBarIndexNotiferProvider =
    StateNotifierProvider<BottomNavBarIndexNotifer, int>((ref) {
  return BottomNavBarIndexNotifer();
});

class BottomNavBarIndexNotifer extends StateNotifier<int> {
  BottomNavBarIndexNotifer() : super(0);
}
