import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Черный кофе',
    cards: [
      CoffeeCardModel(id: 1, name: 'Американо', price: 139, icon: ''),
      CoffeeCardModel(id: 2, name: 'Экспрессо', price: 139, icon: ''),
    ],
  ),
  CategoryModel(
    categoryName: 'Кофе с молоком',
    cards: [
      CoffeeCardModel(id: 3, name: 'Латте', price: 100, icon: 'assets/removal.png'),
      CoffeeCardModel(id: 4, name: 'Капучино', price: 100, icon: 'assets/removal.png'),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    cards: [
      CoffeeCardModel(id: 5, name: 'Черный', price: 150, icon: 'assets/removal.png'),
      CoffeeCardModel(id: 6, name: 'Ягодный', price: 150, icon: 'assets/removal.png'),
    ],
  ),
  CategoryModel(
    categoryName: 'Авторские напитки',
    cards: [
      CoffeeCardModel(id: 7, name: 'Авторский', price: 200, icon: 'assets/removal.png'),
      CoffeeCardModel(id: 8, name: 'Цветочный', price: 200, icon: 'assets/removal.png'),
    ],
  ),
];