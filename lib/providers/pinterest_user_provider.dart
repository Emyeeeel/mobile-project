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

  void addContact(String contact) {
    final List<String> updatedContacts = List.from(state.contacts ?? []);
    updatedContacts.add(contact);
    state = state.copyWith(contacts: updatedContacts);
  }

  void removeContact(String contact) {
    final List<String> updatedContacts = List.from(state.contacts ?? []);
    updatedContacts.remove(contact);
    state = state.copyWith(contacts: updatedContacts);
  }

    void addFollower(String follower) {
    final List<String> updatedFollowers = List.from(state.followers ?? []);
    updatedFollowers.add(follower);
    state = state.copyWith(followers: updatedFollowers);
  }

  void removeFollower(String follower) {
    final List<String> updatedFollowers = List.from(state.followers ?? []);
    updatedFollowers.remove(follower);
    state = state.copyWith(followers: updatedFollowers);
  }

  void addFollowing(String following) {
    final List<String> updatedFollowing = List.from(state.following ?? []);
    updatedFollowing.add(following);
    state = state.copyWith(following: updatedFollowing);
  }

  void removeFollowing(String following) {
    final List<String> removeFollowing = List.from(state.following ?? []);
    removeFollowing.add(following);
    state = state.copyWith(following: removeFollowing);
  }
}

class UserListModel extends StateNotifier<List<UserModel>> {
  UserListModel(List<UserModel> state) : super(state ?? []);

  void addUser(UserModel user) {
    state = [...state, user];
  }

  void removeUser(UserModel user) {
    state = List.from(state)..remove(user);
  }
}

class PinterestUserListModel extends StateNotifier<List<PinterestUser>> {
  PinterestUserListModel(List<PinterestUser> state) : super(state ?? []);

  void addPinterestUser(PinterestUser user) {
    state = [...state, user];
  }

  void removePinterestUser(PinterestUser user) {
    state = List.from(state)..remove(user);
  }
}

final userListProvider = StateNotifierProvider<UserListModel, List<UserModel>>((ref) {
  return UserListModel([]);
});

final pinterestUserListProvider = StateNotifierProvider<PinterestUserListModel, List<PinterestUser>>((ref) {
  return PinterestUserListModel([]);
});

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

final pinterestServicesProvider = Provider((ref) => PinterestServices());