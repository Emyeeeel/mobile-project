import 'package:flutter/cupertino.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_providers.dart';

class EmailPage extends ConsumerWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Column(
      children: [
        const Text(
          'What\'s your email?', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: CupertinoTextField(
              onChanged: (value){
                ref.read(userProvider.notifier).setEmail(value.trim());
              },
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              placeholder: 'Enter your email address',
              placeholderStyle: const TextStyle(color: Color(0xFF8E8E8E)),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: CupertinoColors.black),
                borderRadius: BorderRadius.circular(16),
              ),
          ),
        ),
      ],
    );
  }
}
