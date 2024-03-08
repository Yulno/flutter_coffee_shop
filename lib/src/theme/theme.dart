import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';

final theme = ThemeData(
  cardTheme: const CardTheme(),
  textTheme: const TextTheme(),
);

TextTheme primaryTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: fontfamily600.text,
    fontSize: 32,
    color: AppColors.black,
  ),
  labelLarge: TextStyle(
    fontFamily: fontfamily500.text,
    fontSize: 16,
    color: AppColors.black,
  ),
  labelMedium: TextStyle(
    fontFamily: fontfamily400.text,
    fontSize: 14,
    color: AppColors.white,
  ),
  bodyLarge: TextStyle(
    fontFamily: fontfamily400.text,
    fontSize: 14,
    color: AppColors.black,
  ),
  labelSmall: TextStyle(
    fontFamily: fontfamily400.text,
    fontSize: 12,
    color: AppColors.white,
  ),
);

class FontFamily {
  final String? text;

  FontFamily(this.text);
}

FontFamily fontfamily400 = FontFamily("Roboto400");
FontFamily fontfamily500 = FontFamily("Roboto500");
FontFamily fontfamily600 = FontFamily("Roboto600");


