import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';

class CoffeeCardModel {
  final int id;
  final String name;
  final int price;
  final String icon;
  final CategoryModel category;

  const CoffeeCardModel({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.category,
  });

  factory CoffeeCardModel.fromJSON(Map<String, dynamic> json) {
    return CoffeeCardModel(
      id: json['id'] as int,
      icon: json['imageUrl'] as String,
      name: json['name'] as String,
      price: json['prices'][0]['value'] as int,
      category:
          CategoryModel.fromJSON(json['category'] as Map<String, dynamic>),
    );
  }

}
