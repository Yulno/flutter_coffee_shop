import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/order/order_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_coffee_shop/src/theme/image_sources.dart';

class Item extends StatefulWidget {
  final ItemModel item;

  const Item({super.key, required this.item});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool get selectTheCount => _counter > 0;
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
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
                        imageUrl: widget.item.icon,
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
                      widget.item.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SizedBox(
                      height: 24,
                      child: selectTheCount
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
                                        setState(() {
                                          _counter--;
                                        });
                                        context.read<OrderBloc>().add(
                                              AddCoffee(widget.item, 0),
                                            );
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
                                                horizontal: 8,
                                              )
                                            : const EdgeInsets.symmetric(
                                                horizontal: 2,
                                              ),
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
                                          child:
                                              BlocListener<OrderBloc, OrderState>(
                                            listenWhen: (previous, current) =>
                                                current.status ==
                                                OrderStatus.success,
                                            listener: (context, state) {
                                              _counter = 0;
                                            },
                                            child: Text(
                                              '$_counter',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
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
                                        setState(() {
                                          if (_counter < 10) {
                                            _counter++;
                                            context.read<OrderBloc>().add(
                                                  AddCoffee(
                                                      widget.item, _counter,),
                                                );
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
                                  _counter = 1;
                                });
                                context.read<OrderBloc>().add(
                                      AddCoffee(widget.item, 1),
                                    );
                              },
                              child: Text(
                                '${widget.item.price} ₽',
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
      },
    );
  }
}
