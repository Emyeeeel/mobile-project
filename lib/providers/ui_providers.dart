

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ui_services.dart';

final uiServiceProvider = Provider((ref) => LogInBottomSheet());

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityNotifier, bool>((ref) {
  return PasswordVisibilityNotifier();
});
