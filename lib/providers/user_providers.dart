import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider(User state) : super(state);

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setFullName(String name) {
    state = state.copyWith(name: name);
  }

  void setDob(DateTime dateOfBirth) {
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setLocation(String location) {
    state = state.copyWith(location: location);
  }

  void addTopic(String topic) {
    if (state.selectedTopics.length < 5 && !state.selectedTopics.contains(topic)) {
      state = state.copyWith(selectedTopics: [...state.selectedTopics, topic]);
    }
  }

  void removeTopic(String topic) {
    state = state.copyWith(selectedTopics: state.selectedTopics.where((t) => t != topic).toList());
  }
}

final userProvider = StateNotifierProvider<UserProvider, User>((ref) {
  return UserProvider(User(
    email: '',
    password: '',
    name: '',
    dateOfBirth: null,
    gender: '',
    location: '',
    selectedTopics: [],
  ));
});
