import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/main_page.dart';
import 'landing_page.dart';
import 'main-screens/home_page.dart';

class PinterestClonePage extends StatelessWidget {
  const PinterestClonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          // print("Auth state changed: ${snapshot.connectionState}");
          if (snapshot.hasData){
            // print("User is logged in: ${snapshot.data?.email}");
            return const MainPage();
          }
          else{
            // print("User is not logged in");
            return const LandingPage();
          }
        }),
      ),
    );
  }
}