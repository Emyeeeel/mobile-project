import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/styles.dart';

import '../widgets/log_in_widgets.dart';

class LogInBottomSheet {
  displayLogInInfo(BuildContext context) {
    return showModalBottomSheet(
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
                leading: const Icon(Icons.close),
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
  }
}

class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(false);

  void toggleVisibilityIcon() {
    state = !state;
  }
}
