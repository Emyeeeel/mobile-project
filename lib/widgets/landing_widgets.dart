import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/styles.dart';
import '../providers/ui_providers.dart';
import 'log_in_widgets.dart';

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

class LogInButton extends ConsumerWidget {
  const LogInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext bc) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .90,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        
                      },
                      child: const Icon(Icons.close)
                    ),
                    title: const Text("Log in"),
                    centerTitle: true,
                  ),
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
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 2,),
                  Center(child: EmailTextField()),
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      SizedBox(width: 50,),
                      Text('Password', style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 2,),
                  Center(child: PasswordTextField()),
                  const SizedBox(height: 40,),
                  const Center(child: GenericButton(color: AppStyle.colorRed, text: 'Log in',)),
                  const SizedBox(height: 40,),
                  const Center(child: Text('Forgot your password?')),
                  const SizedBox(height: 20,),
                  const Center(child:  Text('Use iCloud Keychain')),
                ],
              ),
            );
          },
        );
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
