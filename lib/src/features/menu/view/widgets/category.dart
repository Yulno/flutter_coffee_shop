import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/coffee_card.dart';

class Category extends StatelessWidget {
  final CategoryModel category;

  const Category({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            category.categoryName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: 196,
          ),
          itemCount: category.cards.length,
          itemBuilder: (context, index) {
            return CoffeeCard(card: category.cards[index]);
          },
        ),
      ],
    );
  }
}