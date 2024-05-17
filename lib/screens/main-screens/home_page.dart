import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_providers.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authServicesProvider);
    return Scaffold(
      appBar: AppBar(leading: GestureDetector( 
        onTap: (){
            authProvider.signUserOut(context);
          },child: Icon(Icons.exit_to_app)
        ),
      ),
      body: Center(child: Text('Logged in as ' + user.email!),),
    );
  }
}