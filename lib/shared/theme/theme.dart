import 'package:flutter/material.dart';
import 'consts/colors.dart';
import 'consts/fonts.dart';

final ThemeData appThemeData = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: AppColors.primaryMain,
  secondaryHeaderColor: AppColors.primaryPaper,
  scaffoldBackgroundColor: AppColors.backgroundMain,
  cardColor: AppColors.backgroundPaper,
  textTheme: const TextTheme(
    displayLarge: AppFonts.headline1,
    displayMedium: AppFonts.headline2,
    displaySmall: AppFonts.headline3,
    headlineMedium: AppFonts.headline4,
    headlineSmall: AppFonts.headline5,
    bodyLarge: AppFonts.body,
    bodyMedium: AppFonts.small,
    bodySmall: AppFonts.caption,
  ).apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  ),
);