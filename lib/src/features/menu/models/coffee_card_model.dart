class CoffeeCardModel {
  final int id;
  final String name;
  final int price;
  final String icon;

  const CoffeeCardModel({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
  });

  factory CoffeeCardModel.fromJSON(Map<String, dynamic> json) {
    return CoffeeCardModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      icon: json['icon']  as String
    );
  }

  static fromJson(data) {}
}