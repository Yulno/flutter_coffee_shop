import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_card_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_coffee_shop/src/theme/image_sources.dart';

class CoffeeCard extends StatefulWidget {
  final CoffeeCardModel card;

  const CoffeeCard({super.key, required this.card});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return SizedBox(
        width: 180,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: widget.card.icon,
                      placeholder: (context, url) => const Center(
                        child: SizedBox.shrink(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(ImageSources.coffeeIcon),
                      fit: BoxFit.contain,
                    ),
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
                    child: state.cartItems.containsKey(widget.card)
                        ? Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 24,
                                child: Ink(
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: AppColors.blue,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(AddCoffee(widget.card),);
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
                                  padding:
                                      MediaQuery.sizeOf(context).width > 450
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 8,)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 2,),
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
                                        child: BlocBuilder<CartBloc, CartState>(
                                          builder: (context, state) {
                                            return Text(
                                              '${state.cartItems[widget.card]}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            );
                                          },
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
                                    color: AppColors.blue,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(AddCoffee(widget.card),);
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
                              context.read<CartBloc>().add(AddCoffee(widget.card),);
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
    },);
  }
}
