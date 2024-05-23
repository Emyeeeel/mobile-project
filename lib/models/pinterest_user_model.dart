import 'package:pinterest_clone/models/user_model.dart';

class PinterestUser {
  final UserModel? currentUser;
  final String? userName;
  final String? profilePhotoURL;
  final List<String>? contacts;
  final List<String>? following;
  final List<String>? followers;

  PinterestUser({
    required this.currentUser, 
    required this.userName,
    required this.profilePhotoURL, 
    required this.contacts, 
    required this.following, 
    required this.followers
  });

  PinterestUser copyWith({
    UserModel? currentUser,
    String? userName,
    String? profilePhotoURL,
    List<String>? contacts,
    List<String>? following,
    List<String>? followers,
  }) {
    return PinterestUser(
      currentUser: currentUser ?? this.currentUser,
      userName: userName ?? this.userName,
      profilePhotoURL: profilePhotoURL ?? this.profilePhotoURL,
      contacts: contacts ?? this.contacts,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
