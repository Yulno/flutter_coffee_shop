class CategoryModel {
  final String categoryName;
  final int id;

  const CategoryModel({
    required this.categoryName,
    required this.id,
  });

  factory CategoryModel.fromJSON(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['slug'] as String,
      id: json['id'] as int,
    );
  }

  static fromJson(i) {}
}
