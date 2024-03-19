import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/image_sources.dart';

class CoffeeCard extends StatefulWidget {
  final CoffeeCardModel card;

  const CoffeeCard({super.key, required this.card});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  bool get showQuantityButtons => _quantity > 0;

  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: widget.card.icon != null
                      ? Image.network(widget.card.icon!)
                      : Image.asset(ImageSources.coffeeIcon),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  widget.card.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SizedBox(
                  height: 24,
                  child: showQuantityButtons
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.blue),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _quantity--;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 9,
                                  ),
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: MediaQuery.sizeOf(context).width > 450
                                    ? const EdgeInsets.symmetric(horizontal: 8)
                                    : const EdgeInsets.symmetric(horizontal: 2),
                                child: SizedBox(
                                  height: 24,
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color: AppColors.blue,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$_quantity',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              child: Ink(
                                decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.blue),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_quantity < 10) {
                                        _quantity++;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 9,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : FilledButton(
                          onPressed: () {
                            setState(() {
                              _quantity = 1;
                            });
                          },
                          child: Text(
                            '${widget.card.price} руб',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

