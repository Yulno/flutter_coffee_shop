
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/coffee_card.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.cart,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount:
                  BlocProvider.of<CartBloc>(context).state.cartItems.length,
              itemBuilder: (context, index) => CoffeeCard(
                card: (BlocProvider.of<CartBloc>(context)
                    .state
                    .cartItems
                    .keys
                    .toList())[index],
              ),
            ),
          ),
            Container (
              child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(const PostOrder());
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.maxFinite, 56),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.blue,
              ),
              child: Text(
                AppLocalizations.of(context)!.order,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}