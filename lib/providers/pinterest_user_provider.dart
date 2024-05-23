import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/services/user_services.dart';
import '../models/pinterest_user_model.dart';
import '../models/user_model.dart';

class PinterestUserProvider extends StateNotifier<PinterestUser> {
  PinterestUserProvider(PinterestUser state) : super(state);

  void setCurrentUser(UserModel user) {
    state = state.copyWith(currentUser: user);
  }

  void setUserName(String username) {
    state = state.copyWith(userName: username);
  }

  void setProfilePhoto(String profilePhoto) {
    state = state.copyWith(profilePhotoURL: profilePhoto);
  }

  void addContact(PinterestUser user) {
    List<PinterestUser> updatedContacts = List.from(state.contacts ?? []);
    updatedContacts.add(user);
    state = state.copyWith(contacts: updatedContacts);
  }

  void removeContact(PinterestUser user) {
    List<PinterestUser> updatedContacts = List.from(state.contacts ?? []);
    updatedContacts.remove(user);
    state = state.copyWith(contacts: updatedContacts);
  }

  void addFollowing(PinterestUser user) {
    List<PinterestUser> updatedFollowing = List.from(state.following ?? []);
    updatedFollowing.add(user);
    state = state.copyWith(following: updatedFollowing);
  }

  void removeFollowing(PinterestUser user) {
    List<PinterestUser> updatedFollowing = List.from(state.following ?? []);
    updatedFollowing.remove(user);
    state = state.copyWith(following: updatedFollowing);
  }

  void addFollower(PinterestUser user) {
    List<PinterestUser> updatedFollowers = List.from(state.followers ?? []);
    updatedFollowers.add(user);
    state = state.copyWith(followers: updatedFollowers);
  }

  void removeFollower(PinterestUser user) {
    List<PinterestUser> updatedFollowers = List.from(state.followers ?? []);
    updatedFollowers.remove(user);
    state = state.copyWith(followers: updatedFollowers);
  }
}

final pinterestUserProvider = StateNotifierProvider<PinterestUserProvider, PinterestUser>((ref) {
  return PinterestUserProvider(PinterestUser(
    currentUser: null,
    userName: '',
    profilePhotoURL: '',
    contacts: [],
    followers: [],
    following: [],
  ));
});

final pinterestServicesProvider = Provider((ref) => PinterestUserServices());