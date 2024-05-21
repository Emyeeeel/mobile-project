class UserModel {
  final String? email;
  final String? password;
  final String? name;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? location;
  final List<String> selectedTopics;

  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
    required this.selectedTopics,
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    DateTime? dateOfBirth,
    String? gender,
    String? location,
    List<String>? selectedTopics,
  }) {
    return UserModel(
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
