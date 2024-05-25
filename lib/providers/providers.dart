import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/models.dart';

class UserModelNotifier extends StateNotifier<UserModel> {
  UserModelNotifier() : super(UserModel(
      uid: '', 
      email: '',
      password: '',
      name: '',
      birthday: DateTime.now(),
      gender: '',
      countryName: '',
      selectedTopics: [],
    ));

  // Getter for uid
  String get uid => state.uid;

  // Setter for uid
  void setUid(String uid) {
    state = state.copyWith(uid: uid);
  }

  // Getter for email
  String get email => state.email;

  // Setter for email
  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  // Getter for password
  String get password => state.password;

  // Setter for password
  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  // Getter for name
  String get name => state.name;

  // Setter for name
  void setName(String name) {
    state = state.copyWith(name: name);
  }

  // Getter for birthday
  DateTime get birthday => state.birthday;

  // Setter for birthday
  void setBirthday(DateTime birthday) {
    state = state.copyWith(birthday: birthday);
  }

  // Getter for gender
  String get gender => state.gender;

  // Setter for gender
  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  // Getter for countryName
  String get countryName => state.countryName;

  // Setter for countryName
  void setCountryName(String countryName) {
    state = state.copyWith(countryName: countryName);
  }

  // Getter for selectedTopics
  List<String> get selectedTopics => state.selectedTopics;

  // Setter for selectedTopics
  void setSelectedTopics(List<String> selectedTopics) {
    state = state.copyWith(selectedTopics: selectedTopics);
  }

  // Method to add a topic
  void addTopic(String topic) {
    if (state.selectedTopics.length < 5 && !state.selectedTopics.contains(topic)) {
      state = state.copyWith(selectedTopics: [...state.selectedTopics, topic]);
    }
  }

  // Method to remove a topic
  void removeTopic(String topic) {
    state = state.copyWith(selectedTopics: state.selectedTopics.where((t) => t!= topic).toList());
  }

  void resetUserModel() {
    state = UserModel(
      uid: '',
      email: '',
      password: '',
      name: '',
      birthday: DateTime.now(),
      gender: '',
      countryName: '',
      selectedTopics: [],
    );
  }
}

final userModelNotifierProvider = StateNotifierProvider<UserModelNotifier, UserModel>((ref) => UserModelNotifier());



class PinNotifier extends StateNotifier<Pin> {

  PinNotifier() : super(Pin(
      documentId: '', 
      url: '',
      title: '',
      description: '',
      createdAt: DateTime.now(),
      createdBy: '',
   ));

  // Setters for each field
  void setDocumentId(String documentId) {
    state = state.copyWith(documentId: documentId);
  }

  void setUrl(String url) {
    state = state.copyWith(url: url);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setCreatedBy(String createdBy) {
    state = state.copyWith(createdBy: createdBy);
  }

  // Note: Updating createdAt might not be common, but if needed:
  // void setCreatedAt(DateTime createdAt) {
  //   state = state.copyWith(createdAt: createdAt);
  // }

  // Getter for each field
  String get documentId => state.documentId;
  String get url => state.url;
  String get title => state.title;
  String get description => state.description;
  String get createdBy => state.createdBy;
  // DateTime get createdAt => state.createdAt; // Use with caution due to immutability concerns
}


final pinNotifierProvider = StateNotifierProvider<PinNotifier, Pin>((ref) => PinNotifier());


class BoardNotifier extends StateNotifier<Board> {
  BoardNotifier() : super(Board(
    documentId: '', 
    name: '', 
    pinIds: [], 
    createdBy: '', 
    createdAt: DateTime.now()
  ));

  // Setters for each field
  void setDocumentId(String documentId) {
    state = state.copyWith(documentId: documentId);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setPinIds(List<String> pinIds) {
    state = state.copyWith(pinIds: pinIds);
  }

  void addPinId(String newPinId) {
    final currentPinIds = [...state.pinIds]; // Create a copy of the current pinIds list
    if (!currentPinIds.contains(newPinId)) { // Check if the newPinId is not already present
      currentPinIds.add(newPinId); // Add the newPinId to the list
      state = state.copyWith(pinIds: currentPinIds); // Update the state with the new list
    }
  }

  void removePinId(String pinIdToRemove) {
    final currentPinIds = [...state.pinIds]; // Create a copy of the current pinIds list
    currentPinIds.remove(pinIdToRemove); // Remove the specified pinId from the list
    state = state.copyWith(pinIds: currentPinIds); // Update the state with the modified list
  }


  void setCreatedBy(String createdBy) {
    state = state.copyWith(createdBy: createdBy);
  }

  // Note: Updating createdAt might not be common, but if needed:
  // void setCreatedAt(DateTime createdAt) {
  //   state = state.copyWith(createdAt: createdAt);
  // }

  // Getter for each field
  String get documentId => state.documentId;
  String get name => state.name;
  List<String> get pinIds => state.pinIds;
  String get createdBy => state.createdBy;
  // DateTime get createdAt => state.createdAt; // Use with caution due to immutability concerns
}

final boardNotifierProvider = StateNotifierProvider<BoardNotifier, Board>((ref) => BoardNotifier());

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(UserProfile(
    userId: '',
    username: '',
    profilePhotoUrl: '',
    contacts: [],
    following: [],
    followers: [],
    boards: [],
    pins: [],
  ));

  // Getter Methods
  String get userId => state.userId;
  String get username => state.username;
  String get profilePhotoUrl => state.profilePhotoUrl;
  List<String> get contacts => state.contacts;
  List<String> get following => state.following;
  List<String> get followers => state.followers;
  List<String> get boards => state.boards;
  List<String> get pins => state.pins;

  // Setter Methods
  void setUserId(String userId) {
    state = state.copyWith(userId: userId);
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setProfilePhotoUrl(String profilePhotoUrl) {
    state = state.copyWith(profilePhotoUrl: profilePhotoUrl);
  }

  // Adding and Removing Methods for Lists
  void addContact(String contact) {
    final currentContacts = [...state.contacts];
    if (!currentContacts.contains(contact)) {
      currentContacts.add(contact);
      state = state.copyWith(contacts: currentContacts);
    }
  }

  void removeContact(String contact) {
    final currentContacts = [...state.contacts];
    currentContacts.remove(contact);
    state = state.copyWith(contacts: currentContacts);
  }

  void addFollowing(String following) {
    final currentFollowings = [...state.following];
    if (!currentFollowings.contains(following)) {
      currentFollowings.add(following);
      state = state.copyWith(following: currentFollowings);
    }
  }

  void removeFollowing(String following) {
    final currentFollowings = [...state.following];
    currentFollowings.remove(following);
    state = state.copyWith(following: currentFollowings);
  }

  void addFollower(String follower) {
    final currentFollowers = [...state.followers];
    if (!currentFollowers.contains(follower)) {
      currentFollowers.add(follower);
      state = state.copyWith(followers: currentFollowers);
    }
  }

  void removeFollower(String follower) {
    final currentFollowers = [...state.followers];
    currentFollowers.remove(follower);
    state = state.copyWith(followers: currentFollowers);
  }

  void addBoard(String board) {
    final currentBoards = [...state.boards];
    if (!currentBoards.contains(board)) {
      currentBoards.add(board);
      state = state.copyWith(boards: currentBoards);
    }
  }

  void removeBoard(String board) {
    final currentBoards = [...state.boards];
    currentBoards.remove(board);
    state = state.copyWith(boards: currentBoards);
  }

  void addPin(String pin) {
    final currentPins = [...state.pins];
    if (!currentPins.contains(pin)) {
      currentPins.add(pin);
      state = state.copyWith(pins: currentPins);
    }
  }

  void removePin(String pin) {
    final currentPins = [...state.pins];
    currentPins.remove(pin);
    state = state.copyWith(pins: currentPins);
  }
}

final userProfileNotifierProvider  = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) => UserProfileNotifier());
