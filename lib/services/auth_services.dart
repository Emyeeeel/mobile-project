import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/screens/landing_page.dart';

import '../screens/main-screens/home_page.dart';

class TestLogIn extends ConsumerWidget {
  TestLogIn({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authServicesProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Email'),
            TextField(
              controller: emailController,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 50,),
            const Text('Password'),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                border: InputBorder.none,
              ),
            ),
            GestureDetector(
              onTap: (){
                authProvider.signUserIn(context,emailController.text, passwordController.text);
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red
                ),
                child: Text('Log in'),
              ),
            )
          ],
        )
      ),
    );
  }
}

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
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmail(context); //not functioning properly
      } else if (e.code == 'wrong-password') {
        wrongPass(context); //not functioning properly
      }
    }
  }

  void wrongEmail(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('User not found'),
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

  void wrongPass(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Wrong password'),
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
