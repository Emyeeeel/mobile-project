import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/providers/providers.dart';

class GenderPage extends ConsumerStatefulWidget {
  const GenderPage({super.key});

  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends ConsumerState<GenderPage> {
  String? selectedGender;

  List<String> buttonText = [
    'Female',
    'Male',
    'Specify Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'What\'s your gender?',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        const SizedBox(height: 15,),
        const Padding(
          padding: EdgeInsets.fromLTRB(20,0,20,0),
          child: Text(
            'This helps us find you more relevant content. We won’t show it on your profile',
            style: TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30,),
        GenderButton(
          buttonText: buttonText[0],
          isSelected: selectedGender == buttonText[0],
          onPressed: () {
            setState(() {
              selectedGender = buttonText[0];
            });
            ref.read(userModelNotifierProvider.notifier).setGender(buttonText[0].trim());
          },
        ),
        const SizedBox(height: 10,),
        GenderButton(
          buttonText: buttonText[1],
          isSelected: selectedGender == buttonText[1],
          onPressed: () {
            setState(() {
              selectedGender = buttonText[1];
            });
            ref.read(userModelNotifierProvider.notifier).setGender(buttonText[1].trim());
          },
        ),
        const SizedBox(height: 10,),
        GenderButton(
          buttonText: buttonText[2],
          isSelected: selectedGender == buttonText[2],
          onPressed: () {
            setState(() {
              selectedGender = buttonText[2];
            });
            ref.read(userModelNotifierProvider.notifier).setGender(buttonText[2].trim());
          },
        ),
      ],
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({super.key, required this.buttonText, required this.isSelected, required this.onPressed});

  final String buttonText;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(50),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width - 80,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: isSelected ? const Color(0xFFd3d8db) : null,
        child: Text(buttonText, style: const TextStyle(color: Colors.black, fontSize: 18),),
      ),
    );
  }
}
