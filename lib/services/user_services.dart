import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/providers/user_providers.dart';

class UserServices {
  List<String> userIdList = [];
  List<Map<String, dynamic>> userInfoList = [];
  Map<String, dynamic> currentUserData = {};

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> getDocID() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    userIdList = snapshot.docs.map((doc) => doc.id).toList();
  }

  Future<List<Map<String, dynamic>>> getAllUsersInfo() async {
    for (String userId in userIdList) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      Map<String, dynamic> userData = snapshot.data()!;
      userInfoList.add(userData);
    }
    return userInfoList;
  }

    Future<void> getCurrentUserDetails(WidgetRef ref) async {
    await getDocID();
    await getAllUsersInfo();
    for (int i = 0; i < userInfoList.length; i++) {
      if (userInfoList[i]['email'] == currentUser.email!) {
        currentUserData = userInfoList[i];
        break; 
      }
    }

    // Move these lines inside the method
    DateTime dateOfBirth = DateTime.parse(currentUserData['dateOfBirth']);
    List<dynamic> selectedTopicsDynamic = currentUserData['selectedTopics'] ?? [];
    List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
    final user = ref.watch(userProvider.notifier);
    user.state = UserModel(
      email: currentUserData['email'], 
      password: currentUserData['password'], 
      name: currentUserData['name'], 
      dateOfBirth: dateOfBirth, 
      gender: currentUserData['gender'], 
      location: currentUserData['location'], 
      selectedTopics: selectedTopics
    );
  }
}
