import 'package:flutter_coffee_shop/src/features/menu/models/category_model.dart';

class ItemModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String icon;
  final CategoryModel category;

  const ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.category,
  });
}
