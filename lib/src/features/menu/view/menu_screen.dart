import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/category.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/coffee_title.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/coffee_card.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: [
          Category(),
          CoffeeTitle(coffeeTitle: firstCoffeeTitle),
          CoffeeCard(coffeeCard: card1),
          CoffeeTitle(coffeeTitle: secondCoffeeTitle),
          CoffeeCard(coffeeCard: card1),
          CoffeeTitle(coffeeTitle: thirdCoffeeTitle),
          CoffeeCard(coffeeCard: card1),
          CoffeeTitle(coffeeTitle: fourCoffeeTitle),
          CoffeeCard(coffeeCard: card1),
        ],
      ),
    );
  }
}
