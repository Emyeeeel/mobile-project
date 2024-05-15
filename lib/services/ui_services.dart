import 'package:flutter/material.dart';
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
            children: [
              AppBar(
                leading: Icon(Icons.close),
                title: Text("Log in"),
                centerTitle: true,
              ),
              const FacebookButton(),
              const SizedBox(height: 10,),
              const GoogleButton(),
              const SizedBox(height: 10,),
              const AppleButton()
            ],
          ),
        );
      },
    );
  }
}
