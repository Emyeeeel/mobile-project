import 'package:flutter/material.dart';

class AppStyle{
  static const colorRed = Color(0xFFE70125);
  static const colorWhiteGrey = Color(0xFFEFEFEF);
  static const colorBlue = Color(0xFF4286F5);
  static const colorDarkBlue = Color(0xFF3C5996);
  static const colorBlack = Color(0xFF0F0E0F);
  static const borderColor = Color(0xFFCECDCE);

  static const TextStyle buttonRedText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: colorWhiteGrey
  );

  static const TextStyle buttonWhiteText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: colorBlack
  );

  static const TextStyle landingHeader = TextStyle(
    fontFamily: 'Inter',
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: colorBlack
  );

  static const TextStyle googleButton = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: colorWhiteGrey
  );

  static const TextStyle appleButton = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: colorBlack
  );

  static const TextStyle detailsTitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle detailsSubtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle detailsTitlePin = TextStyle(
    color: colorWhiteGrey,
    fontFamily: 'Inter',
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle detailsSubtitlePin = TextStyle(
    color: colorWhiteGrey,
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );
}