import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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