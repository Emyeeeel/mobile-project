import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/auth_providers.dart';
import '../../../widgets/main_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServicesProvider);
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded)
                  ),
                  const Spacer(),
                  const Text('Your Account'),
                  const Spacer(),
                  const SizedBox(width: 20,),
                ],
              ),
              const SizedBox(height: 50,),
              const Row(children: [SizedBox(width: 20,),Text('Settings')],),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Account management'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Profile visibility'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Home feed tuner'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Claimed accounts'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Social permissions'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Notifications'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Privacy and data'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Reports and violations center'),
              const SizedBox(height: 50,),
              const Row(children: [SizedBox(width: 20,),Text('Log in')],),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Add Account'),
              const SizedBox(height: 15,),
              const RowWidget(text: 'Security'),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  GestureDetector(
                    onTap: (){
                      auth.signUserOut(context, ref);
                    },
                    child: const Text('Logout')
                  )
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  const SizedBox(width: 20,),
                  Text(text),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded)
                  ),
                  const SizedBox(width: 20,),
                ],
              );
  }
}