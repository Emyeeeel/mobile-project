import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/styles.dart';

import '../../providers/sign_in_providers.dart';

class EmailPage extends ConsumerWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailTextEditingController = TextEditingController();
    return Column(
      children: [
        const Text(
          'What\'s your email?', 
          textAlign: TextAlign.center,
          style: TextStyle(color: AppStyle.colorBlack, fontWeight: FontWeight.w600, fontSize: 22, fontFamily: 'Inter'),
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: CupertinoTextField(
              controller: emailTextEditingController, 
              onChanged: (value){
                ref.read(emailStringValueProvider.notifier).state = value;
              },
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              placeholder: 'Enter your email address',
              placeholderStyle: const TextStyle(color:  Color(0xFF91908F)),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: const Color(0xFF7F7A79)),
                borderRadius: BorderRadius.circular(16),
              ),
          ),
        ),
      ],
    );
  }
}