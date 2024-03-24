import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';

class CategoryModel {
  final String categoryName;
  final List<CoffeeCardModel> cards;

  const CategoryModel({
    required this.categoryName,
    required this.cards,
  });

  factory CategoryModel.fromJSON(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'] as String,
      cards: json['cards'] as List<CoffeeCardModel>,
    );
  }

  static fromJson(i) {}
}