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
