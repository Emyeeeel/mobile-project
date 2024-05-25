class UserModel {
  final String uid;
  final String email;
  final String password; 
  final String name;
  final DateTime birthday;
  final String gender;
  final String countryName;
  final List<String> selectedTopics;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.countryName,
    required this.selectedTopics,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? password, 
    String? name,
    DateTime? birthday,
    String? gender,
    String? countryName,
    List<String>? selectedTopics,
  }) {
    return UserModel(
      uid: uid?? this.uid,
      email: email?? this.email,
      password: password?? this.password,
      name: name?? this.name,
      birthday: birthday?? this.birthday,
      gender: gender?? this.gender,
      countryName: countryName?? this.countryName,
      selectedTopics: selectedTopics?? this.selectedTopics,
    );
  }
}

class Pin {
  final String documentId; 
  final String url;
  final String title;
  final String description;
  final String createdBy;
  final DateTime createdAt;

  Pin({
    required this.documentId, 
    required this.url,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  Pin copyWith({
    String? documentId,
    String? url,
    String? title,
    String? description,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Pin(
      documentId: documentId?? this.documentId,
      url: url?? this.url,
      title: title?? this.title,
      description: description?? this.description,
      createdBy: createdBy?? this.createdBy,
      createdAt: createdAt?? this.createdAt,
    );
  }
}

class Board {
  final String documentId; 
  final String name;
  final List<String> pinIds;
  final String createdBy;
  final DateTime createdAt;

  Board({
    required this.documentId, 
    required this.name,
    required this.pinIds,
    required this.createdBy,
    required this.createdAt,
  });

  Board copyWith({
    String? documentId,
    String? name,
    List<String>? pinIds,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Board(
      documentId: documentId?? this.documentId,
      name: name?? this.name,
      pinIds: pinIds?? this.pinIds,
      createdBy: createdBy?? this.createdBy,
      createdAt: createdAt?? this.createdAt,
    );
  }
}



class UserProfile {
  final String userId; 
  final String username; 
  final String profilePhotoUrl; 
  final List<String> contacts; 
  final List<String> following;
  final List<String> followers;
  final List<String> boards;
  final List<String> pins;

  UserProfile({
    required this.userId, 
    required this.username, 
    required this.profilePhotoUrl, 
    required this.contacts, 
    required this.following, 
    required this.followers, 
    required this.boards, 
    required this.pins
  });

  UserProfile copyWith({
    String? userId,
    String? username,
    String? profilePhotoUrl,
    List<String>? contacts,
    List<String>? following,
    List<String>? followers,
    List<String>? boards,
    List<String>? pins,
  }) {
    return UserProfile(
      userId: userId?? this.userId,
      username: username?? this.username,
      profilePhotoUrl: profilePhotoUrl?? this.profilePhotoUrl,
      contacts: contacts?? this.contacts,
      following: following?? this.following,
      followers: followers?? this.followers,
      boards: boards?? this.boards,
      pins: pins?? this.pins,
    );
  }
}


