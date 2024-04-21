import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/bottomsheet_scroll.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
   child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Scaffold(
        body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.cart,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(const DeleteOrder());
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: BottomSheetScroll(
                  order: context.watch<CartBloc>().state.cartItems,
                ),
              ),
              BlocListener<CartBloc, CartState>(
                listener: (context, state) {
                  if (state.status == CartStatus.success) {
                    context.read<CartBloc>().add(
                          const DeleteOrder(),
                        );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(AppLocalizations.of(context)!.success,
                            style: Theme.of(context).textTheme.labelLarge,),
                      ),
                    );
                  }
                  if (state.status == CartStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(AppLocalizations.of(context)!.error,
                            style: Theme.of(context).textTheme.labelLarge,),
                      ),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(const PostOrder());
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
        ),
      ),
    );
  }
}
