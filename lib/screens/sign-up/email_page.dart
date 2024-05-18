import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/models/user_model.dart';
import 'package:pinterest_clone/screens/sign-up/password_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPage extends ConsumerWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 35),
            Text(
              'What’s your email?',
              style: GoogleFonts.inter(
                color: const Color(0xFFEFEFEF),
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
                border: Border.all(width: 1, color: const Color(0xFFFFFFFF)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    ref.read(userProvider.notifier).setEmail(value.trim());
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              text: 'Next',
              textColor: 'white',
              buttonColor: 'red',
              onPressed: () {
                if (user.email!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
