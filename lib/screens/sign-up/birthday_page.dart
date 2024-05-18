import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinterest_clone/screens/sign-up/gender_page.dart';
import 'package:pinterest_clone/widgets/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/models/user_model.dart';

class BirthdayPage extends ConsumerStatefulWidget {
  const BirthdayPage({Key? key}) : super(key: key);

  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends ConsumerState<BirthdayPage> {
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              Text(
                'Full Name',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEFEFEF),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextField(
                          controller: nameController,
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  NameButton(
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty) {
                        ref.read(userProvider.notifier).setFullName(nameController.text.trim());
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'Birthday',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEFEFEF),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  maximumYear: DateTime.now().year,
                  minimumYear: DateTime.now().year - 100,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
              const Spacer(),
              ButtonWidget(
                text: 'Next',
                textColor: 'white',
                buttonColor: 'red',
                onPressed: () {
                  ref.read(userProvider.notifier).setDob(selectedDate);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}