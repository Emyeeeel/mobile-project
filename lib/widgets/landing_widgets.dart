import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/screens/log_in_page.dart';
import 'package:pinterest_clone/styles.dart';


class LandingPageWidget extends ConsumerWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height / 3),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text('Welcome to Pinterest', style: AppStyle.landingHeader),
          const SizedBox(height: 20),
          const SignInButton(),
          const SizedBox(height: 10),
          const LogInButton(),
          const SizedBox(height: 15),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(color: AppStyle.colorBlack),
              children: <TextSpan>[
                TextSpan(
                  text: 'By continuing, you agree to Pinterest’s ',
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: AppStyle.colorBlue, fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: ' and acknowledge you\'ve read our ',
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: AppStyle.colorBlue, fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: '. ',
                ),
                TextSpan(
                  text: 'Notice at collection',
                  style: TextStyle(color: AppStyle.colorBlue, fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: '.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){},
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: AppStyle.colorRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text('Sign up', style: AppStyle.buttonRedText),
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
      },
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: AppStyle.colorWhiteGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text('Log in', style: AppStyle.buttonWhiteText),
    );
  }
}