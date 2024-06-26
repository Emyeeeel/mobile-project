import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/providers.dart';
import 'package:pinterest_clone/screens/sign-up/sign_up_page.dart';

class BirthdayPage extends ConsumerWidget {
  const BirthdayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ref.watch(userModelNotifierProvider.notifier).state.name.isEmpty ? SetName() : const DisplayName(),
        ),
        const SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            width: 400,
            child: Text(
              'To help keep Pinterest safe, we now require your birthdate. Your birthdate also helps us provide more personalized recommendations and relevant ads. We don’t share this information and it won’t be visible on your profile.',
              textAlign: TextAlign.center,  
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
              ref.read(userModelNotifierProvider.notifier).setBirthday(newDateTime);
            },
          ),
        ),
      ],
    );
  }
}

class SetName extends ConsumerWidget {
  SetName({super.key});

  final TextEditingController nameTextController = TextEditingController();
  late String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Column(
        children: [
          const Text(
            'Hey ', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/2 + 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 2, color: Colors.black), 
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: nameTextController,
                                onChanged: (value) {
                                  userName = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Enter your name',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  nameTextController.clear();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  MaterialButton(
                    onPressed: (){
                      ref.read(userModelNotifierProvider.notifier).setName(userName.trim());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    color: Colors.red,
                    minWidth: MediaQuery.of(context).size.width/4,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayName extends ConsumerWidget {
  const DisplayName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0,15,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hey ${ref.watch(userModelNotifierProvider.notifier).state.name}!', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),),
              const SizedBox(width: 10,),
              IconButton(icon: const Icon(Icons.edit), onPressed: () {
                ref.read(userModelNotifierProvider.notifier).setName('');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
