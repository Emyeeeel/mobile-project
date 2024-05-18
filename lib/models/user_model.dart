import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class User {
  final String? email;
  final String? password;
  final String? name;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? location;
  final List<String> selectedTopics;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
    required this.selectedTopics,
  });

  User copyWith({
    String? email,
    String? password,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    List<String>? selectedTopics,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      selectedTopics: selectedTopics ?? this.selectedTopics,
    );
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
