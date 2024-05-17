import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/screens/landing_page.dart';

import '../screens/main-screens/home_page.dart';

class TestAuthPage extends StatelessWidget {
  const TestAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          print("Auth state changed: ${snapshot.connectionState}");
          if (snapshot.hasData){
            print("User is logged in: ${snapshot.data?.email}");
            return HomePage();
          }
          else{
            print("User is not logged in");
            return LandingPage();
          }
        }),
      ),
    );
  }
}

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

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
  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
