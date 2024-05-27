
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
  void signUserIn(BuildContext context, String email, String password, WidgetRef ref) async {
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
      await getUserInfo(ref);
      await setContactsList(ref);
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

  Future<void> getUserInfo (WidgetRef ref) async {
    String email = FirebaseAuth.instance.currentUser!.email!;
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

      final userProfile = ref.watch(userProfileNotifierProvider.notifier);
      userProfile.setUserId(user.uid);

      QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('pinterest_users_profile')
      .where('userId', isEqualTo: userProfile.userId)
      .get();

      if (!snapshot.docs.isEmpty){
        DocumentSnapshot docSnapshot = snapshot.docs.first;
        List<dynamic> contactsDynamic = docSnapshot['contacts'] ?? [];
        List<String> contacts = contactsDynamic.map((topic) => topic.toString()).toList();

        List<dynamic> followersDynamic = docSnapshot['followers'] ?? [];
        List<String> followers = followersDynamic.map((topic) => topic.toString()).toList();

        List<dynamic> followingDynamic = docSnapshot['following'] ?? [];
        List<String> following = followingDynamic.map((topic) => topic.toString()).toList();

        List<dynamic> boardsDynamic = docSnapshot['boards'] ?? [];
        List<String> boards = boardsDynamic.map((topic) => topic.toString()).toList();

        List<dynamic> pinsDynamic = docSnapshot['pins'] ?? [];
        List<String> pins = pinsDynamic.map((topic) => topic.toString()).toList();

        userProfile.state = UserProfile(
          userId: user.uid, 
          username: docSnapshot['username'], 
          profilePhotoUrl: docSnapshot['profilePhotoUrl'], 
          contacts: contacts, 
          following: following, 
          followers: followers, 
          boards: boards, 
          pins: pins
        );

      }
    } else {
      print("No matching documents found for email: $email");
    }
  }

  Future<void> setContacts(String documentId, WidgetRef ref) async {
    final contactsList = ref.watch(contactListProvider.notifier);
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('pinterest_users')
      .doc(documentId)
      .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> userData = docSnapshot.data() as Map<String, dynamic>;
        List<dynamic> selectedTopicsDynamic = docSnapshot['selectedTopics'] ?? [];
        List<String> selectedTopics = selectedTopicsDynamic.map((topic) => topic.toString()).toList();
        UserModel user = UserModel(
          uid: docSnapshot['uid'], 
          email: docSnapshot['email'], 
          password: docSnapshot['password'], 
          name: docSnapshot['name'], 
          birthday: DateTime.parse(docSnapshot['birthday']), 
          gender: docSnapshot['gender'], 
          countryName: docSnapshot['countryName'], 
          selectedTopics: selectedTopics
        );
        contactsList.addUserInfo(user);

        QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pinterest_users_profile')
        .where('userId', isEqualTo: user.uid)
        .get();

        if (!snapshot.docs.isEmpty){
          DocumentSnapshot docSnapshot = snapshot.docs.first;
          List<dynamic> contactsDynamic = docSnapshot['contacts'] ?? [];
          List<String> contacts = contactsDynamic.map((topic) => topic.toString()).toList();

          List<dynamic> followersDynamic = docSnapshot['followers'] ?? [];
          List<String> followers = followersDynamic.map((topic) => topic.toString()).toList();

          List<dynamic> followingDynamic = docSnapshot['following'] ?? [];
          List<String> following = followingDynamic.map((topic) => topic.toString()).toList();

          List<dynamic> boardsDynamic = docSnapshot['boards'] ?? [];
          List<String> boards = boardsDynamic.map((topic) => topic.toString()).toList();

          List<dynamic> pinsDynamic = docSnapshot['pins'] ?? [];
          List<String> pins = pinsDynamic.map((topic) => topic.toString()).toList();

          UserProfile user_profile = UserProfile(
            userId: user.uid, 
            username: docSnapshot['username'], 
            profilePhotoUrl: docSnapshot['profilePhotoUrl'], 
            contacts: contacts, 
            following: following, 
            followers: followers, 
            boards: boards, 
            pins: pins
          );
          contactsList.addUserProfile(user_profile);
        }        

      } else {
        print("Document with ID '$documentId' does not exist.");
      }
    } catch (e) {
      print("Error fetching user profile details: $e");
    }
  }

  Future<void> setContactsList(WidgetRef ref) async{
    final userContacts = ref.watch(userProfileNotifierProvider.notifier);
    for(int i = 0; i < userContacts.contacts.length; i++){
      await setContacts(userContacts.contacts[i], ref);
    }
  }
  
  void sendPinData (WidgetRef ref) async {
    Pin currentUser = ref.read(pinNotifierProvider.notifier).state;

    Map<String, dynamic> userDataMap = {
      'documentId': currentUser.documentId,
      'url': currentUser.url,
      'userId': currentUser.userId, 
      'description': currentUser.description,
      'createdBy': currentUser.createdBy,
      'createdAt': currentUser.createdAt.toIso8601String(), 
    };

    try {
      await FirebaseFirestore.instance.collection('pinterest_users_pins').add(userDataMap);
      print("User saved successfully");

    } catch (e) {
      print("Error saving user: $e");
    }
  }

  void updatePinUIDAndSave(WidgetRef ref) async {
    final userId = ref.read(userModelNotifierProvider.notifier).uid;

    List<String> docId = [];
    
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('pinterest_users_pins')
    .where('userId', isEqualTo: userId)
    .get();

    for (var doc in querySnapshot.docs) {
      docId.add(doc.id);
    }

    ref.read(userProfileNotifierProvider.notifier).setPins(docId);

    for (String id in docId) {
      await FirebaseFirestore.instance.collection('pinterest_users_pins').doc(id).update({
        'documentId': id,
      });
    }
  }
  
  List<String> urls = [];
  Future<void> getSavedList (WidgetRef ref) async {
    urls.clear();
    List<String> links = [];
   final userId = ref.read(userModelNotifierProvider.notifier).uid;
    
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('pinterest_users_pins')
    .where('userId', isEqualTo: userId)
    .get();

    for (var doc in querySnapshot.docs) {
      String url = doc['url']; 
      links.add(url);
    }
    urls = links;
    ref.read(userProfileNotifierProvider.notifier).setPins(urls);
  }
}


final backendeServicesProvider = Provider<BackendeServices>((ref) => BackendeServices());
