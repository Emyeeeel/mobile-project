import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui_providers.dart';
import '../styles.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {},
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: AppStyle.colorDarkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text(
        'Continue with Facebook',
        style: AppStyle.googleButton,
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {},
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: AppStyle.colorBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Text(
        'Continue with Google',
        style: AppStyle.googleButton,
      ),
    );
  }
}

class AppleButton extends StatelessWidget {
  const AppleButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {},
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: AppStyle.colorWhiteGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.apple, size: 20,),
            SizedBox(width: 5,),
            Text(
              'Continue with Apple',
              style: AppStyle.appleButton,
            ),
          ],
        ),
      ),
    );
  }
}

class GenericButton extends StatelessWidget {
  const GenericButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onPressed, // New parameter for onPressed callback
  }) : super(key: key);

  final Color color;
  final String text;
  final VoidCallback onPressed; // Callback to be executed when the button is pressed

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed, // Use the provided onPressed callback
      minWidth: MediaQuery.of(context).size.width - 80,
      height: 50,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: AppStyle.googleButton,
      ),
    );
  }
}


class EmailTextField extends StatelessWidget {
  EmailTextField({Key? key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: AppStyle.borderColor)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}


class PasswordTextField extends ConsumerWidget {
  PasswordTextField({Key? key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTapped = ref.watch(passwordVisibilityProvider);
    return Container(
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
                controller: textController,
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
    );
  }
}