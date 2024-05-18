import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/screens/sign-up/gender_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';

class BirthdayPage extends ConsumerWidget {
  const BirthdayPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'Hey ', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20,0,20,0),
          child: SizedBox(
            width: 400,
            child: Text(
              textAlign: TextAlign.center,  
              'To help  keep Pinterest safe, we now require your birthdate. Your birthdate also helps us provide more personalized recommendations and relevant ads. We don’t share this information and it won’t be visible on you profile.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.mdy,
            initialDateTime: DateTime.now(), 
            onDateTimeChanged: (DateTime newDateTime) {
            },
          ),
        ),
      ],
    );
  }
}