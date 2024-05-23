import 'package:pinterest_clone/models/user_model.dart';

class PinterestUser {
  final UserModel? currentUser;
  final String? userName;
  final String? profilePhotoURL;
  final List<PinterestUser>? contacts;
  final List<PinterestUser>? following;
  final List<PinterestUser>? followers;

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
    List<PinterestUser>? contacts,
    List<PinterestUser>? following,
    List<PinterestUser>? followers,
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
