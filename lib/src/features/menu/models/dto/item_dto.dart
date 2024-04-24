import 'package:flutter_coffee_shop/src/features/menu/models/dto/category_dto.dart';

class ItemDto {
  final int id;
  final String name;
  final String description;
  final double price;
  final String icon;
  final CategoryDto category;

  const ItemDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.category,
  });

  factory ItemDto.fromJSON(Map<String, dynamic> json) {
    if (json['prices'] is! List<dynamic> || json['category'] is! Map<String, dynamic>) throw const FormatException();
    final prices = json['prices'];
    return ItemDto(
      id: json['id'] as int,
      icon: json['icon'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: double.parse(
        prices.first is! Map<String, dynamic>
            ? throw const FormatException()
            : prices.first['value'].toString(),
      ),
      category: CategoryDto.fromJSON(json['category'] as Map<String, dynamic>),
    );
  }
}