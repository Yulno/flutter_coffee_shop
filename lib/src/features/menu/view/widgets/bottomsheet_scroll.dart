import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/image_sources.dart';

class BottomSheetScroll extends StatelessWidget {
  const BottomSheetScroll({Key? key, required this.order}) : super(key: key);

  final Map<CoffeeCardModel, int> order;

  @override
  Widget build(BuildContext context) {
    final List<CoffeeCardModel> coffee = order.entries.expand((entry) => List.generate(entry.value, (_) => entry.key)).toList(); 
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            coffee[index].icon,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset(ImageSources.coffeeIcon),
            fit: BoxFit.contain,
            width: 55,
          ),
          title: Text(
            coffee[index].name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: Text(
            "${coffee[index].price} руб",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.black),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: coffee.length,
    );
  }
}
