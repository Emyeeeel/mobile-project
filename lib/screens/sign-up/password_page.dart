import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/screens/sign-up/birthday_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';

class PasswordPage extends ConsumerWidget {
  PasswordPage({Key? key}) : super(key: key);

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 35),
            Text(
              'Create a password',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F0E0F),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 380,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFF0F0E0F)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: passwordController,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF0F0E0F),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const Spacer(),
            ButtonWidget(
              text: 'Next',
              textColor: 'white',
              buttonColor: 'red',
              onPressed: () {
                if (passwordController.text.trim().isNotEmpty) {
                  ref.read(userProvider.notifier).setPassword(passwordController.text.trim());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BirthdayPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
