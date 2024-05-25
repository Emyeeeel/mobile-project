
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../providers/providers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/ui_providers.dart';
import '../screens/landing_page.dart';
import '../widgets/main_page.dart';

class BackendeServices {
  void signUserIn(BuildContext context, String email, String password) async {
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password, 
      );
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 
      if (e.code == 'user-not-found') {
        print('User not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password');
      } else {
        print('Authentication failed.'); 
      }
    }
  }
  void signUserOut(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );
    try {
      await FirebaseAuth.instance.signOut();
      ref.watch(bottomNavigationProvider.notifier).setSelectedIndex(0);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); 
      if (e.code == 'user-not-found') {
        print('User not found');
      } else if (e.code == 'wrong-password') {
        print('Wrong password');
      } else {
        print('Authentication failed.'); 
      }
    }
  }

  void createUser(WidgetRef ref) async {
    try{
      final user = ref.read(userModelNotifierProvider);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email, 
        password: user.password
      );
    }catch (e){
      print('Error creating user: $e');
    }
  }

  void saveUserToFirestore(WidgetRef ref) async {
    UserModel currentUser = ref.read(userModelNotifierProvider.notifier).state;

    Map<String, dynamic> userDataMap = {
      'uid': currentUser.uid,
      'email': currentUser.email,
      'password': currentUser.password, 
      'name': currentUser.name,
      'birthday': currentUser.birthday.toIso8601String(), 
      'gender': currentUser.gender,
      'countryName': currentUser.countryName,
      'selectedTopics': currentUser.selectedTopics.map((topic) => topic).toList(), 
    };



    try {
      await FirebaseFirestore.instance.collection('pinterest_users').add(userDataMap);
      print("User saved successfully");
    } catch (e) {
      print("Error saving user: $e");
    }
  }

  void updateUserUIDAndSave(WidgetRef ref) async {
    final currentUser = ref.watch(userModelNotifierProvider.notifier);

    String userEmail = currentUser.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('pinterest_users')
      .where('email', isEqualTo: userEmail)
      .get();

    if (!querySnapshot.docs.isEmpty) {
      currentUser.setUid(querySnapshot.docs.first.id);

      Map<String, dynamic> updateData = {
        'uid': currentUser.uid,
        'email': currentUser.email,
        'password': currentUser.password, 
        'name': currentUser.name,
        'birthday': currentUser.birthday.toIso8601String(),
        'gender': currentUser.gender,
        'countryName': currentUser.countryName,
        'selectedTopics': currentUser.selectedTopics.map((topic) => topic).toList(),
      };

      final userProfile = ref.watch(userProfileNotifierProvider.notifier);
      userProfile.setUserId(updateData['uid']);

      await FirebaseFirestore.instance
      .collection('pinterest_users')
      .doc(currentUser.uid) 
      .update(updateData);

      UserProfile user_profile = UserProfile(
        userId: currentUser.uid,
        username: '',
        profilePhotoUrl: '',
        contacts: [],
        following: [],
        followers: [],
        boards: [],
        pins: [],
      );
      
      Map<String, dynamic> userDataMap = {
        'userId': currentUser.uid,
        'username': '',
        'profilePhotoUrl': '', 
        'contacts': [],
        'following': [], 
        'followers': [],
        'boards': [],
        'pins': [], 
      };

      try {
        await FirebaseFirestore.instance.collection('pinterest_users_profile').add(userDataMap);
        print("User saved successfully");
      } catch (e) {
        print("Error saving user: $e");
      }

    } else {
      print("No matching documents found.");
    }
  }

  Future<void> getUserDataByEmail(String email, WidgetRef ref) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('pinterest_users')
    .where('email', isEqualTo: email)
    .get();

    if (!querySnapshot.docs.isEmpty) {
      DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      List<dynamic> selectedTopicsDynamic = docSnapshot['selectedTopics'] ?? [];
      List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
      final user = ref.watch(userModelNotifierProvider.notifier);
      user.state = UserModel(
        uid: docSnapshot['uid'], 
        email: docSnapshot['email'], 
        password: docSnapshot['password'], 
        name: docSnapshot['name'], 
        birthday: DateTime.parse(docSnapshot['birthday']), 
        gender: docSnapshot['gender'], 
        countryName: docSnapshot['countryName'], 
        selectedTopics: selectedTopics
      );
    } else {
      print("No matching documents found for email: $email");
    }
  }

}


final backendeServicesProvider = Provider<BackendeServices>((ref) => BackendeServices());


