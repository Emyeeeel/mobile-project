import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/pinterest_user_model.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/providers/user_providers.dart';

import '../providers/pinterest_user_provider.dart';

class PinterestServices{

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

    List<dynamic> contactsDynamic = pinterestUserTableInfoList[pinterestUserIndex]['contacts'] ?? [];
    List<String> contacts = contactsDynamic.map((topic) => topic.toString()).toList();

    List<dynamic> followersDynamic = pinterestUserTableInfoList[pinterestUserIndex]['followers'] ?? [];
    List<String> followers = followersDynamic.map((topic) => topic.toString()).toList();

    List<dynamic> followingDynamic = pinterestUserTableInfoList[pinterestUserIndex]['following'] ?? [];
    List<String> following = followingDynamic.map((topic) => topic.toString()).toList();

    final pinterestUser = ref.watch(pinterestUserProvider.notifier);
    pinterestUser.state = PinterestUser(
      currentUser: user.state, 
      userName: truncateEmail(user.state.email!), 
      profilePhotoURL: pinterestUserTableInfoList[pinterestUserIndex]['profilePhoto'], 
      contacts: contacts, 
      following: followers, 
      followers: following
    );
  }
  
    Future<void> sendUsersDataToPinterestTable(WidgetRef ref) async {
    DateTime dateOfBirth = DateTime.parse(userInfo['dateOfBirth']);
    List<dynamic> selectedTopicsDynamic = userInfo['selectedTopics'] ?? [];
    List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
    UserModel userTable = UserModel(
      email: userInfo['email'], 
      password: userInfo['password'], 
      name: userInfo['name'], 
      dateOfBirth: dateOfBirth, 
      gender: userInfo['gender'], 
      location: userInfo['location'], 
      selectedTopics: selectedTopics
    );

    await FirebaseFirestore.instance.collection('pinterest_users').add({
        'userId': userTableDocIds[userIndex],
        'userName': truncateEmail(userTable.email!),
        'profilePhoto': null,
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
  

  // UserModel getUserInfoByDocID (String docID) {
  //   int index = 0;
  //   for(int i = 0; i < userTableDocIds.length; i++){
  //     if(docID == userTableDocIds[i]){

  //     }
  //   }
  //   Map<String, dynamic> userInfoByDocID = usersTableInfoList[index];
  //   DateTime dateOfBirth = DateTime.parse(userInfoByDocID['dateOfBirth']);
  //   List<dynamic> selectedTopicsDynamic = userInfoByDocID['selectedTopics'] ?? [];
  //   List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();

  //   UserModel user_model = UserModel(
  //     email: userInfoByDocID['email'],
  //     password: userInfoByDocID['password'],
  //     name: userInfoByDocID['name'],
  //     dateOfBirth: dateOfBirth,
  //     gender: userInfoByDocID['gender'],
  //     location: userInfoByDocID['location'],
  //     selectedTopics: selectedTopics,
  //   );
  //   return user_model;
  // }

  // List<UserModel> listOfUsersContacts = [];

  // List<UserModel> getContacts (List<String> usersUID) {
  //   List<UserModel> userContacts = [];
  //   for(int i = 0; i < userTableDocIds.length; i++){
  //     for(int j = 0; j < usersUID.length; j++){
  //       if(userTableDocIds[i] == usersUID[j]){
  //         Map<String, dynamic> userInfoByDocID = usersTableInfoList[i];
  //         DateTime dateOfBirth = DateTime.parse(userInfoByDocID['dateOfBirth']);
  //         List<dynamic> selectedTopicsDynamic = userInfoByDocID['selectedTopics'] ?? [];
  //         List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();

  //         UserModel user_model = UserModel(
  //           email: userInfoByDocID['email'],
  //           password: userInfoByDocID['password'],
  //           name: userInfoByDocID['name'],
  //           dateOfBirth: dateOfBirth,
  //           gender: userInfoByDocID['gender'],
  //           location: userInfoByDocID['location'],
  //           selectedTopics: selectedTopics,
  //         );
  //         userContacts.add(user_model);
  //       }
  //     }
  //   }

  //   return userContacts;
  // }
}