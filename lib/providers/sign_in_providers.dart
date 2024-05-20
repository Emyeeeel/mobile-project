import 'package:flutter_riverpod/flutter_riverpod.dart';


final emailStringValueProvider = StateProvider<String>((ref) => '');

final passStringValueProvider = StateProvider<String>((ref) => '');

final nameStringValueProvider = StateProvider<String>((ref) => '');

final dateOfBirthProvider = StateProvider<DateTime>((ref) => DateTime.now());

final List<StateProvider> stringProviders = [
  emailStringValueProvider,
  passStringValueProvider,
  nameStringValueProvider,
  dateOfBirthProvider
];

final isDateTimeProvider = Provider.family<bool, int>((ref, selectedIndex) {
  final selectedProvider = stringProviders[selectedIndex];
  return ref.read(selectedProvider.notifier).state == DateTime.now();
});