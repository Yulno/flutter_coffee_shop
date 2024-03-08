import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/theme.dart';

class CoffeeTitle extends StatelessWidget {
  final CoffeeTitleClass coffeeTitle;
  const CoffeeTitle({super.key, required this.coffeeTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 16, bottom: 16, left: 32),
        child: Text(
          coffeeTitle.title,
          style: TextStyle(
            fontFamily: fontfamily600.text,
            fontSize: 32,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
