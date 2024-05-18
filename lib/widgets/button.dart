import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final String textColor;
  final String buttonColor;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        textColor == 'white' ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    Color _buttonColor =
        buttonColor == 'red' ? const Color(0xFFE70125) : const Color(0xFFFFFFFF);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 380,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _buttonColor,
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: _textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}



class NameButton extends StatefulWidget {
  final Function() onPressed;
  const NameButton({super.key, required this.onPressed});

  @override
  State<NameButton> createState() => _NameButtonState();
}

class _NameButtonState extends State<NameButton> {
  late Color _textColor;
  late Color _buttonColor;
  @override
  void initState() {
    super.initState();
    _buttonColor = const Color(0xFFE70125);
    _textColor =  const Color(0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:widget.onPressed,
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _buttonColor,
            ),
            child: Center(
              child: Text(
                "Update",
                style: GoogleFonts.inter(
                  color: _textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
  }
}