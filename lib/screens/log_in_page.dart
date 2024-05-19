import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import '../providers/ui_providers.dart';
import '../styles.dart';
import '../widgets/log_in_widgets.dart';
import 'landing_page.dart';

class LogInPage extends ConsumerWidget {
  LogInPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTapped = ref.watch(passwordVisibilityProvider);
    final authProvider = ref.watch(authServicesProvider);
    return Scaffold(
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: AppBar( 
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LandingPage()));
                },
                child: const Icon(Icons.close)
              ),
              title: const Text("Log in"),
              centerTitle: true,
            ),
          ),
          const SizedBox(height: 30,),
          const Center(child: FacebookButton()),
          const SizedBox(height: 10,),
          const Center(child: GoogleButton()),
          const SizedBox(height: 10,),
          const Center(child: AppleButton()),
          const SizedBox(height: 10,),
          const Center(child: Text('OR')),
          const Row(
            children: [
              SizedBox(width: 50,),
              Text('Email', style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
              Spacer(),
            ],
          ),
          const SizedBox(height: 2,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2, color: AppStyle.borderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ),
          const SizedBox(height: 30,),
          const Row(
            children: [
              SizedBox(width: 50,),
              Text('Password', style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )),
              Spacer(),
            ],
          ),
          const SizedBox(height: 2,),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 2, color: AppStyle.borderColor), 
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
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
            )
          ),
          const SizedBox(height: 40,),
          Center(
            child: GenericButton(
              color: AppStyle.colorRed,
              text: 'Log in',
              onPressed: () {
                authProvider.signUserIn(context, _emailController.text, _passwordController.text);
              },
            ),
          ),
          const SizedBox(height: 40,),
          const Center(child: Text('Forgot your password?')),
          const SizedBox(height: 20,),
          const Center(child: Text('Use iCloud Keychain')),
        ],
      ),
    );
  }
}
