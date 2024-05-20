import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/auth_providers.dart';

class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServicesProvider);
    return Center(
      child: Column(
        children: [
          const Text('Saved Page'),
          const SizedBox(height: 20,),
          MaterialButton(
            onPressed: (){
              auth.signUserOut(context, ref);
            },
            minWidth: 250,
            height: 80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.red,
            child: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}
