import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ui_services.dart';

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityNotifier, bool>((ref) {
  return PasswordVisibilityNotifier();
});

//  return BottomNavigationService();
final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>(
        (ref) => BottomNavigationNotifier());

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0); // Initial value

  void setSelectedIndex(int index) {
    state = index;
  }
}

final uiServiceProvider = Provider((ref) => PhotoDetails());
