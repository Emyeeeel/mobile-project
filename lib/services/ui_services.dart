import 'package:flutter_riverpod/flutter_riverpod.dart';


class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(false);

  void toggleVisibilityIcon() {
    state = !state;
  }
}
