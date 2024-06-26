
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/auth_providers.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/providers/user_providers.dart';
import 'package:pinterest_clone/screens/sign-up/gender_page.dart';
import 'package:pinterest_clone/screens/sign-up/interested_in_page.dart';
import 'package:pinterest_clone/screens/sign-up/location_page.dart';
import 'package:pinterest_clone/services/services.dart';
import '../../providers/ui_providers.dart';
import '../landing_page.dart';
import 'birthday_page.dart';
import 'email_page.dart';
import 'password_page.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});


  static final List<Widget> _widgetOptions = <Widget>[
    EmailPage(),
    PasswordPage(),
    const BirthdayPage(),
    const GenderPage(),
    const LocationsPage(),
    const InterestedInPage(),
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
                      6,
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
               if(selectedIndex == _widgetOptions.length - 1){
                final service = ref.watch(backendeServicesProvider);
                service.saveUserToFirestore(ref);
                service.updateUserUIDAndSave(ref);
                service.createUser(ref);
                ref.watch(bottomNavigationProvider.notifier).setSelectedIndex(0);
               }
               else{
                ref.read(bottomNavigationProvider.notifier).setSelectedIndex(nextIndex);
               }
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

class DisplayUserData extends ConsumerWidget {
  const DisplayUserData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Column(
      children: [
        Text('Email: ${user.email}'),
        Text('Password: ${user.password}'),
        Text('Name: ${user.name}'),
        Text('Birthday: ${user.dateOfBirth!.toIso8601String()}'),
        Text('Location: ${user.location}'),
        Text('Selected Topc: ${user.selectedTopics[0]} ${user.selectedTopics[1]} ${user.selectedTopics[2]} ${user.selectedTopics[3]} ${user.selectedTopics[4]}'),
      ],
    );
  }
}