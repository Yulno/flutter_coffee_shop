import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/theme.dart';

class Category extends StatelessWidget {
  final List<String> themes = [
    "Черный кофе",
    "Кофе с молоком",
    "Чай",
    "Авторские напитки",
  ];

  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, left: 32),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: themes.map((text) {
                  return TextButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 36),
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center),
                    child: Text(
                      text,
                      style: theme.primaryTextTheme.titleLarge,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
