
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/screens/sign-up/gender_page.dart';
import 'package:pinterest_clone/screens/sign-up/interested_in_page.dart';
import 'package:pinterest_clone/screens/sign-up/location_page.dart';

import '../../providers/ui_providers.dart';
import '../landing_page.dart';
import 'birthday_page.dart';
import 'email_page.dart';
import 'password_page.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const EmailPage(),
    PasswordPage(),
    const BirthdayPage(),
    GenderPage(),
    LocationPage(),
    InterestedInPage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 25,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final prevIndex = selectedIndex - 1;
                      if (prevIndex < 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage()));
                      }
                      else{
                        ref.read(bottomNavigationProvider.notifier).setSelectedIndex(prevIndex);
                      }
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      7,
                      (index) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          ((index < selectedIndex) || (index == selectedIndex)) ? Icons.circle : Icons.circle_outlined,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          _widgetOptions.elementAt(selectedIndex),
          const Spacer(),
          MaterialButton(
            onPressed: () {
                final nextIndex = selectedIndex + 1;
               ref.read(bottomNavigationProvider.notifier).setSelectedIndex(nextIndex);
            },
            minWidth: MediaQuery.of(context).size.width - 40,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.red,
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }
}
