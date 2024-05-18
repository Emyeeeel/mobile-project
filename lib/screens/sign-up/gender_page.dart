import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/screens/sign-up/interested_in_page.dart';
import 'package:pinterest_clone/screens/sign-up/location_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';

class GenderPage extends ConsumerWidget {
  GenderPage({Key? key}) : super(key: key);

  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Column(
          children: [
            const SizedBox(height: 35),
            Text(
              'Gender',
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
                  controller: genderController,
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFFFFFF),
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
                if (genderController.text.trim().isNotEmpty) {
                  ref.read(userProvider.notifier).setGender(genderController.text.trim());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InterestedInPage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your gender')),
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
