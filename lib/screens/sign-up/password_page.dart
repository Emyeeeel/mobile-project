import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/ui_providers.dart';
import '../../providers/user_providers.dart';

class PasswordPage extends ConsumerWidget {
  PasswordPage({super.key});

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isTapped = ref.watch(passwordVisibilityProvider);
    return Column(
      children: [
        const Text(
          'Create a password', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10,),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2, color: Colors.black), 
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        ref.read(userProvider.notifier).setPassword(value.trim());
                      },
                      obscureText: !isTapped,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        isTapped ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        ref.read(passwordVisibilityProvider.notifier).toggleVisibilityIcon();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
