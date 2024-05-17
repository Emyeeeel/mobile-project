import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/main-screens/home_page.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Dismiss loading indicator
      if (e.code == 'user-not-found') {
        showErrorMessage(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showErrorMessage(context, 'Wrong password');
      } else {
        showErrorMessage(context, 'Authentication failed'); // Handle other errors
      }
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  Future<void> signUserOut(BuildContext context) async {
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      }
    );
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Dismiss loading indicator
      if (e.code == 'user-not-found') {
        showErrorMessage(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showErrorMessage(context, 'Wrong password');
      } else {
        showErrorMessage(context, 'Authentication failed'); // Handle other errors
      }
    }

  }
}
