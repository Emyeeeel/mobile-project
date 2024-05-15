import 'package:flutter/material.dart';
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

class EmailTextField extends StatelessWidget {
  EmailTextField({Key? key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: const Color(0xFF000000))
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  PasswordTextField({Key? key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: const Color(0xFF000000))
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Enter your password',
            border: InputBorder.none,
            suffix: Icon(Icons.visibility, color: AppStyle.colorBlack,)
          ),
        ),
      ),
    );
  }
}
