import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';

const categories = [
  CategoryModel(
    categoryName: 'Черный кофе',
    cards: [
      CoffeeCardModel(name: 'Американо', price: 139),
      CoffeeCardModel(name: 'Экспрессо', price: 139),
    ],
  ),
  CategoryModel(
    categoryName: 'Кофе с молоком',
    cards: [
      CoffeeCardModel(name: 'Латте', price: 100),
      CoffeeCardModel(name: 'Капучино', price: 100),
    ],
  ),
  CategoryModel(
    categoryName: 'Чай',
    cards: [
      CoffeeCardModel(name: 'Черный', price: 150),
      CoffeeCardModel(name: 'Ягодный', price: 150),
    ],
  ),
  CategoryModel(
    categoryName: 'Авторские напитки',
    cards: [
      CoffeeCardModel(name: 'Авторский', price: 200),
      CoffeeCardModel(name: 'Цветочный', price: 200),
    ],
  ),
];