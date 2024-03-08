import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/theme.dart';

class CoffeeCard extends StatelessWidget {
  final CoffeeCardClass coffeeCard;
  const CoffeeCard({super.key, required this.coffeeCard});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 196,
          margin: const EdgeInsets.only(left: 32),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Image.asset(coffeeCard.icon, height: 100),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  coffeeCard.name,
                  style: TextStyle(
                    fontFamily: fontfamily400.text,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(116, 24),
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center),
                child: Text(
                  coffeeCard.price,
                  style: theme.primaryTextTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 196,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Image.asset(coffeeCard.icon, height: 100),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  coffeeCard.name,
                  style: TextStyle(
                    fontFamily: fontfamily400.text,
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(116, 24),
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    alignment: Alignment.center),
                child: Text(
                  coffeeCard.price,
                  style: theme.primaryTextTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
