import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';

class ItemModel {
  final int id;
  final String name;
  final String description;
  final String icon;
  final double price;
  final CategoryModel category;

  const ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.price,
    required this.category,
  });
}
