import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/pinterest_user_model.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/providers/user_providers.dart';

import '../providers/pinterest_user_provider.dart';

// class UserServices {
//   List<String> userIdList = [];
//   List<Map<String, dynamic>> userInfoList = [];
//   Map<String, dynamic> currentUserData = {};

//   final currentUser = FirebaseAuth.instance.currentUser!;

//   Future<void> getDocID() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection('users').get();
//     userIdList = snapshot.docs.map((doc) => doc.id).toList();
//   }

//   Future<List<Map<String, dynamic>>> getAllUsersInfo() async {
//     for (String userId in userIdList) {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//       Map<String, dynamic> userData = snapshot.data()!;
//       userInfoList.add(userData);
//     }
//     return userInfoList;
//   }

//     Future<void> getCurrentUserDetails(WidgetRef ref) async {
//     await getDocID();
//     await getAllUsersInfo();
//     for (int i = 0; i < userInfoList.length; i++) {
//       if (userInfoList[i]['email'] == currentUser.email!) {
//         currentUserData = userInfoList[i];
//         break; 
//       }
//     }

//     DateTime dateOfBirth = DateTime.parse(currentUserData['dateOfBirth']);
//     List<dynamic> selectedTopicsDynamic = currentUserData['selectedTopics'] ?? [];
//     List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
//     final user = ref.watch(userProvider.notifier);
//     user.state = UserModel(
//       email: currentUserData['email'], 
//       password: currentUserData['password'], 
//       name: currentUserData['name'], 
//       dateOfBirth: dateOfBirth, 
//       gender: currentUserData['gender'], 
//       location: currentUserData['location'], 
//       selectedTopics: selectedTopics
//     );

//     final pinterestUser = ref.watch(pinterestUserProvider.notifier);
//     pinterestUser.state = PinterestUser(
//       currentUser: user.state, 
//       userName: truncateEmail(user.state.email!), 
//       profilePhotoURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtyx6E49clWdMD5nH6Iv27e6SZRh4IzzZxt8O1yMb205gfyRxzX9wKMyt468XAq9DVv1c&usqp=CAU', 
//       contacts: [], 
//       following: [], 
//       followers: []);
      
//       PinterestUser current = PinterestUser(
//         currentUser: user.state, 
//         userName: truncateEmail(user.state.email!), 
//         profilePhotoURL: 'null', 
//         contacts: [], 
//         following: [], 
//         followers: []
//       );
//   }

//   String truncateEmail(String email) {
//     int atIndex = email.indexOf('@');
//     if (atIndex != -1) {
//       return email.substring(0, atIndex);
//     }
//     return email;
//   }
// }


class PinterestUserServices{

  List<String> getAllUsersDocID = [];
  List<String> getAllPinterstUsersDocID = [];

  List<Map<String, dynamic>> userInfoList = [];
  List<Map<String, dynamic>> pinterestUserInfoList = [];
  int userIndex = 0;
  int pinterestUserIndex = 0;

  void setUserIndex (int num){
    userIndex = num;
  }

  void setPinterestUserIndex (int num){
    pinterestUserIndex = num;
  }

  Map<String, dynamic> currentUserData = {};
  Map<String, dynamic> currentPinterestUserData = {};

  final currentUser = FirebaseAuth.instance.currentUser!;

  bool isUserInPinterestUserTable = false;

  Future<void> getUsersDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    getAllUsersDocID = snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<void> getPinterestUsersDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('pinterest_users').get();
    getAllPinterstUsersDocID = snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<List<Map<String, dynamic>>> getAllUsersInfo() async {
    for (String userId in getAllUsersDocID) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      Map<String, dynamic> userData = snapshot.data()!;
      userInfoList.add(userData);
    }
    return userInfoList;
  }

  Future<List<Map<String, dynamic>>> getAllPinterestUsersInfo() async {
    for (String userId in getAllPinterstUsersDocID) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('pinterest_users')
          .doc(userId)
          .get();
      Map<String, dynamic> userData = snapshot.data()!;
      pinterestUserInfoList.add(userData);
    }
    return pinterestUserInfoList;
  }

  Future<void> getCurrentPinterestUserDetails(WidgetRef ref) async {
    await getUsersDocID();
    await getPinterestUsersDocID();
    await getAllUsersInfo();
    await getAllPinterestUsersInfo();

    for (int i = 0; i < userInfoList.length; i++) {
      if (userInfoList[i]['email'] == currentUser.email!) {
        setUserIndex(i);
        break; 
      }
    }

    for (int j = 0; j < pinterestUserInfoList.length; j++){
      if(pinterestUserInfoList[j]['userId'] ==  getAllUsersDocID[userIndex]){
        setPinterestUserIndex(j);
      }
    }

    Map<String, dynamic> userInfo = userInfoList[userIndex];
    Map<String, dynamic> pinterestUserInfo = pinterestUserInfoList[pinterestUserIndex];

    currentUserData = userInfoList[userIndex];

    DateTime dateOfBirth = DateTime.parse(userInfo['dateOfBirth']);
    List<dynamic> selectedTopicsDynamic = userInfo['selectedTopics'] ?? [];
    List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
    final user = ref.watch(userProvider.notifier);
    user.state = UserModel(
      email: userInfo['email'], 
      password: userInfo['password'], 
      name: userInfo['name'], 
      dateOfBirth: dateOfBirth, 
      gender: userInfo['gender'], 
      location: userInfo['location'], 
      selectedTopics: selectedTopics
    );

    final pinterestUser = ref.watch(pinterestUserProvider.notifier);
    pinterestUser.setCurrentUser(user.state);

    pinterestUser.setUserName(pinterestUserInfo['userName']);
    pinterestUser.setProfilePhoto(pinterestUserInfo['profilePhoto']);
  }

  Future<bool> checkUser () async {
    await getUsersDocID();
    await getPinterestUsersDocID();
    await getAllUsersInfo();
    await getAllPinterestUsersInfo();

    for (int i = 0; i < userInfoList.length; i++) {
      if (userInfoList[i]['email'] == currentUser.email!) {
        setUserIndex(i);
        currentUserData = userInfoList[i];
        break; 
      }
    }

    for (int j = 0; j < pinterestUserInfoList.length; j++){
      if(pinterestUserInfoList[j]['userId'] ==  getAllUsersDocID[userIndex]){
        setPinterestUserIndex(j);
        currentPinterestUserData = pinterestUserInfoList[j];
        isUserInPinterestUserTable = true;
        return true;
      }
    }
    return false;
  }

  Future<void> sendUsersDataToPinterestTable(WidgetRef ref) async {
    DateTime dateOfBirth = DateTime.parse(currentUserData['dateOfBirth']);
    List<dynamic> selectedTopicsDynamic = currentUserData['selectedTopics'] ?? [];
    List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
    UserModel userTable = UserModel(
      email: currentUserData['email'], 
      password: currentUserData['password'], 
      name: currentUserData['name'], 
      dateOfBirth: dateOfBirth, 
      gender: currentUserData['gender'], 
      location: currentUserData['location'], 
      selectedTopics: selectedTopics
    );

    await FirebaseFirestore.instance.collection('pinterest_users').add({
        'userId': getAllUsersDocID[userIndex],
        'userName': truncateEmail(userTable.email!),
        'profilePhoto': '',
        'contacts': [], 
        'following': [], 
        'followers': [],
        'boards': [],
        'pins': []
      });
  }

  String truncateEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }
    return email;
  }
}


class TestServices{

  List<String> userTableDocIds = [];
  List<String> pinterestUserTableDocIds = [];

  List<Map<String, dynamic>> usersTableInfoList = [];
  List<Map<String, dynamic>> pinterestUserTableInfoList = [];

  Map<String, dynamic> userInfo = {};
  Map<String, dynamic> pinterestUserInfo = {};

  final currentUser = FirebaseAuth.instance.currentUser!;

  int userIndex = 0;
  int pinterestUserIndex = 0;

  Future<void> getUsersDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    userTableDocIds = snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<void> getPinterestUsersDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('pinterest_users').get();
    pinterestUserTableDocIds = snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<List<Map<String, dynamic>>> getAllUsersTableInfo() async {
    for (String userId in userTableDocIds) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      Map<String, dynamic> userData = snapshot.data()!;
      usersTableInfoList.add(userData);
    }
    return usersTableInfoList;
  }

  Future<List<Map<String, dynamic>>> getAllPinterestUsersInfo() async {
    for (String userId in pinterestUserTableDocIds) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('pinterest_users')
          .doc(userId)
          .get();
      Map<String, dynamic> userData = snapshot.data()!;
      pinterestUserTableInfoList.add(userData);
    }
    return pinterestUserTableInfoList;
  }

  Future<void> getCurrentPinterestUserDetails (WidgetRef ref) async {
    await getUsersDocID();
    await getPinterestUsersDocID();
    await getAllUsersTableInfo();
    await getAllPinterestUsersInfo();
    for(int i = 0; i < userTableDocIds.length; i++){
      if(usersTableInfoList[i]['email'] == currentUser.email){
        userInfo = usersTableInfoList[i];
        userIndex = i;
      }
    }

    for(int i = 0; i < pinterestUserTableDocIds.length; i++){
      if(pinterestUserTableInfoList[i]['userID'] == userTableDocIds[userIndex]){
        pinterestUserInfo = pinterestUserTableInfoList[i];
        pinterestUserIndex = i;
      }
    }

    DateTime dateOfBirth = DateTime.parse(userInfo['dateOfBirth']);
    List<dynamic> selectedTopicsDynamic = userInfo['selectedTopics'] ?? [];
    List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();

    final user = ref.watch(userProvider.notifier);
    user.state = UserModel(
      email: userInfo['email'], 
      password: userInfo['password'], 
      name: userInfo['name'], 
      dateOfBirth: dateOfBirth, 
      gender: userInfo['gender'], 
      location: userInfo['location'], 
      selectedTopics: selectedTopics
    );

    final pinterestUser = ref.watch(pinterestUserProvider.notifier);
    pinterestUser.state = PinterestUser(
      currentUser: user.state, 
      userName: truncateEmail(user.state.email!), 
      profilePhotoURL: pinterestUserInfo['profilePhoto'], 
      contacts: [], 
      following: [], 
      followers: []
    );
  }

  String truncateEmail(String email) {
    int atIndex = email.indexOf('@');
    if (atIndex != -1) {
      return email.substring(0, atIndex);
    }
    return email;
  }

}

final testServicesProvider = Provider((ref) => TestServices());