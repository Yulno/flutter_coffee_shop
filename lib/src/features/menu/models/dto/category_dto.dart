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
}