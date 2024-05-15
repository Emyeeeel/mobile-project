import 'package:flutter/material.dart';

class AppStyle{
  static const colorRed = Color(0xFFE70125);
  static const colorWhiteGrey = Color(0xFFEFEFEF);
  static const colorBlue = Color(0xFF4286F5);
  static const colorBlack = Color(0xFF0F0E0F);

  static const TextStyle buttonRedText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: colorWhiteGrey
  );

  static const TextStyle buttonWhiteText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: colorBlack
  );

  static const TextStyle landingHeader = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: colorBlack
  );

}