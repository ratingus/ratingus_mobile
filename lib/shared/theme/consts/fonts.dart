import 'package:flutter/material.dart';

abstract class AppFonts {
  static const headline1 = TextStyle(fontWeight: FontWeight.w500, fontSize: 48);
  static const headline2 = TextStyle(fontWeight: FontWeight.w500, fontSize: 32);
  static const headline3 = TextStyle(fontWeight: FontWeight.w500, fontSize: 24);
  static const headline4 = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  static const headline5 = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);

  static const body = TextStyle(fontWeight: FontWeight.w300, fontSize: 14);
  static const bodyMedium = TextStyle(fontWeight: FontWeight.w500, fontSize: 14);

  static const small = TextStyle(fontWeight: FontWeight.w300, fontSize: 12);
  static const smallMedium = TextStyle(fontWeight: FontWeight.w500, fontSize: 12);

  static const caption = TextStyle(fontWeight: FontWeight.w300, fontSize: 10);
  static const captionMedium = TextStyle(fontWeight: FontWeight.w500, fontSize: 10);
}