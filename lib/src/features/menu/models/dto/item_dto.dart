import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';
import 'package:flutter_coffee_shop/src/common/data_base/database.dart';

class ItemDto {
  final int id;
  final String name;
  final String icon;
  final String description;
  final double price;
  final CategoryDto category;

  const ItemDto({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.price,
    required this.category,
  });

  factory ItemDto.fromJSON(Map<String, dynamic> json) {
    if (json['prices'] is! List<dynamic> ||
        json['category'] is! Map<String, dynamic>)
      throw const FormatException();
    final prices = json['prices'];
    return ItemDto(
      id: json['id'] as int,
      name: json['name'] as String,
      icon: json['imageUrl'] as String,
      description: json['description'] as String,
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: CategoryDto.fromJSON(json['category'] as Map<String, dynamic>),
    );
  }

  factory ItemDto.fromDB(item, category) {
    return ItemDto(
      id: item.id as int,
      name: item.name as String,
      description: item.description as String,
      icon: item.icon as String,
      price: item.price as double,
      category: CategoryDto(id: category.id as int, slug: category.slug as String),
    );
  }
}
