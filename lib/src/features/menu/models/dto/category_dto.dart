import 'package:flutter_coffee_shop/src/common/data_base/database.dart';

class CategoryDto {
  final String slug;
  final int id;

  const CategoryDto({
    required this.slug,
    required this.id,
  });

  factory CategoryDto.fromJSON(Map<String, dynamic> json) {
    return CategoryDto(
      slug: json['slug'] as String,
      id: json['id'] as int,
    );
  }
  
  factory CategoryDto.fromDB(Category category) {
    return CategoryDto(slug: category.slug, id: category.id);
  }
}