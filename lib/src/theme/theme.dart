import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';

final theme = ThemeData(
  cardTheme: const CardTheme(
    color: AppColors.white,
    margin: EdgeInsets.all(0),
    shadowColor: AppColors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Roboto600',
      fontSize: 32,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto500',
      fontSize: 16,
      color: AppColors.black,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Roboto400',
      fontSize: 24,
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Roboto700',
      fontSize: 24,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto700',
      fontSize: 16,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto400',
      fontSize: 14,
      color: AppColors.black,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto400',
      fontSize: 12,
      color: AppColors.white,
    ),
  ),
  filledButtonTheme: const FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.blue),
    ),
  ),
);
