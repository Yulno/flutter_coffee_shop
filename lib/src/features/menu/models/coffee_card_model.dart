class CoffeeCardModel {
  final String name;
  final int price;
  final String? icon;

  const CoffeeCardModel({
    required this.name,
    required this.price,
    this.icon,
  });

  factory CoffeeCardModel.fromJSON(Map<String, dynamic> json) {
    return CoffeeCardModel(
      icon: json['icon'],
      name: json['name'],
      price: json['price'],
    );
  }

}