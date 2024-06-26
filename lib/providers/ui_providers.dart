import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ui_services.dart';

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityNotifier, bool>((ref) {
  return PasswordVisibilityNotifier();
});

final uiServiceProvider = Provider((ref) => PhotoDetails());

final bottomNavigationProvider = StateNotifierProvider<BottomNavigationService, int>((ref) {
  return BottomNavigationService();
});

final createPinUIProvider = Provider((ref) => CreatePin());