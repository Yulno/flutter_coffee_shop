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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      icon: json['icon']
    );
  }

  static fromJson(data) {}
}