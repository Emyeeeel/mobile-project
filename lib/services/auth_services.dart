import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinterest_clone/providers/ui_providers.dart';
import 'package:pinterest_clone/widgets/main_page.dart';
import '../providers/user_providers.dart';
import '../screens/landing_page.dart';

class AuthServices {
  Future<void> signUserIn(BuildContext context, String email, String password) async {
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
        showErrorMessage(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showErrorMessage(context, 'Wrong password');
      } else {
        showErrorMessage(context, 'Authentication failed.'); 
      }
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error logging in'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> signUserOut(BuildContext context, WidgetRef ref) async {
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
        showErrorMessage(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showErrorMessage(context, 'Wrong password');
      } else {
        showErrorMessage(context, 'Authentication failed.'); 
      }
    }
  }

  Future<void> createUser(BuildContext context, WidgetRef ref) async {
    try{
      final user = ref.read(userProvider);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email!, 
        password: user.password!
      );
    }catch (e){
      print('Error creating user: $e');
    }
  }

  Future<void> sendUsersData(BuildContext context, WidgetRef ref) async {
    try {
      final user = ref.read(userProvider);

      String dateOfBirthString = user.dateOfBirth!.toIso8601String();

      final firestore = FirebaseFirestore.instance;

      await firestore.collection('users').add({
        'email': user.email,
        'password': user.password,
        'name': user.name,
        'dateOfBirth': dateOfBirthString,
        'gender': user.gender,
        'location': user.location,
        'selectedTopics': user.selectedTopics
      });

      createUser(context, ref);
      resetUserInfo(context, ref);
      showDialog(
        context: context, 
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        }
      );
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage())
    );
    } catch (e) {
      print('Error sending user data: $e');
    }
  }

  Future<void> resetUserInfo (BuildContext context, WidgetRef ref) async{
    final user = ref.read(userProvider.notifier);
    user.resetUser();
  }
}
